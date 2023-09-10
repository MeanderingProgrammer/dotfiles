# ASDF setup
export ASDF_SRC="$(brew --prefix asdf)/libexec/asdf.sh"
[[ -f $ASDF_SRC ]] && source "${ASDF_SRC}"

# Airflow setup
export AIRFLOW_DIR="$HOME/airflow"
[[ -d $AIRFLOW_DIR ]] && export AIRFLOW_HOME=$AIRFLOW_DIR
