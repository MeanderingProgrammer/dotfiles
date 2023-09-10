# ASDF setup
if [[ $(brew --prefix asdf 2> /dev/null) ]]
then
    source "$(brew --prefix asdf)/libexec/asdf.sh"
fi

# Airflow setup
export AIRFLOW_DIR="$HOME/airflow"
[[ -d $AIRFLOW_DIR ]] && export AIRFLOW_HOME=$AIRFLOW_DIR
