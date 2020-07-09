#!/bin/sh

function prune_existing_environment(){
    read -p "may I prune your existing docker containers before we continue? (y or n)? " yn
    case $yn in
        [Yy]* )  docker rm -f $(docker ps -q); echo -e "\nsystem prune attempted, moving forward with a clean(er) environment";;
        [Nn]* ) echo "continuing without clean environment";;
        * ) echo "Please answer yes or no.";prune_existing_environment;;
    esac
}

function get_number_of_challenges(){
    echo "How many challenges would you like to instantiate?"
    read -p "Enter number of challenges in this direcory: " num_challenges
}

function get_flags(){
    echo "enter your flags in the following format: flag_{this_is_an_example_flag}"
    set -a
    for ((i = 1;i<=num_challenges;i++)); do
        declare -n flag_name_ref="FLAG_$i"
        read -p "Enter flag #$i: " flag_name_ref
        validate_user_input $flag_name_ref
        echo "flag #$i set to: ${flag_name_ref}"
    done
    set +a
    echo "flags have been created successfully!"
}

function validate_user_input(){
    read -p "GREAT, would you like to move forward with $1 (y or n)? " yn
    case $yn in
        [Yy]* ) echo "great, lets continue";;
        [Nn]* ) echo "alright, lets try this again (CTR+C to quit)";main;;
        * ) echo "Please answer yes or no.";validate_user_input;;
    esac
}

function build_images(){
    echo "starting building your $num_challenges challenge images..."
    for ((i = 1;i<=num_challenges;i++)); do
        if [ ! -d "challenge_$i" ]; then
            echo "## ERROR ##: unable to find challenge directory: challenge_$i"
            echo "try again after this challenge directory has been added."
            kill -INT $$
        fi
        declare -n flag_name_ref="FLAG_$i"
        docker build -t challenge_image_$i --build-arg FLAG=$flag_name_ref ./challenge_$i
        echo "## CHALLENGE IMAGE $i CREATED ##"
    done
    echo -e "\n\n## CHALLENGE IMAGES BUILT SUCCESSFULLY! ##"
    docker images | grep challenge_image
}

function create_containers(){
    for ((i = 1;i<=num_challenges;i++)); do
        if [ -z $(docker images -q challenge_image_1) ]; then
            echo "## ERROR ##: unable to find challenge image: challenge_image_$i"
            echo "try again after this image has been added."
            kill -INT $$
        fi
        docker run -d -P --name challenge_container_$i challenge_image_$i
        if [ "$( docker container inspect -f '{{.State.Status}}' challenge_container_$i )" != "running" ]; then
            echo "## ERROR ##: unable to create the challenge container from image: challenge_image_$i"
            echo "check the image definition and try again."
            kill -INT $$
        fi
        echo "## CHALLENGE CONTAINER $i CREATED ##"
    done
    echo -e "\n\n## CHALLENGE CONTAINERS BUILT SUCCESSFULLY! ##"
    docker ps | grep challenge_image
}
function main(){
    prune_existing_environment
    get_number_of_challenges
    validate_user_input $num_challenges
    get_flags
    build_images
    validate_user_input "generating the containers locally?"
    create_containers
    kill -INT $$
}
main