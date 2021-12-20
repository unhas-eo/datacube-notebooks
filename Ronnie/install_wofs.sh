#!/usr/bin/env bash

# Create and configure a new virtual env to run WOfS within EASI

venv=unhas
venv_name="UNHAS2 Environment"
venv_root=~/.venv
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
repos_dir=${script_dir}/../..

function create_venv() {
    # Create a virtual env if not already there
    if ! $(jupyter kernelspec list | grep -q ${venv}); then
        echo "Creating virtual env. Please wait..."
        mkdir -p ${venv_root}
        python -m venv ${venv_root}/${venv}
        realpath /env/lib/python3.8/site-packages > ${venv_root}/${venv}/lib/python3.8/site-packages/base_venv.pth
        source ${venv_root}/${venv}/bin/activate
        python -m ipykernel install --user --name=${venv} --display-name "${venv_name}"
        deactivate
    fi
}

function install_dependencies() {
    # Install WOfS python dependencies
    echo "Creating/updating python dependencies. Please wait..."
    source ${venv_root}/${venv}/bin/activate
    pip install -U ephem
    pip install -U --index-url https://packages.dea.ga.gov.au/ wofs
    deactivate
}

function clone_repos() {
    # Clore required repos
    echo "Cloning additional repos. Please wait..."
    if [ ! -d ${repos_dir}/hub-notebooks ] ; then
        git clone --depth=1 https://csiro-easi@dev.azure.com/csiro-easi/easi-hub-public/_git/hub-notebooks ${repos_dir}/hub-notebooks
    fi
}

create_venv
install_dependencies
clone_repos
