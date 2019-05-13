FROM python:2.7

LABEL "com.github.actions.name"="Test Assembler (End-To-End)"
LABEL "com.github.actions.description"="Run tests"
LABEL "com.github.actions.icon"="mic"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/mjgpy3/R32V2020"
LABEL "homepage"=""
LABEL "maintainer"="mjgpy3"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
