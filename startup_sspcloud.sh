#!/bin/sh

# Create variables
WORK_DIR=/home/onyxia/work/spatial-impact-evaluation
REPO_URL=https://${GIT_PERSONAL_ACCESS_TOKEN}@github.com/fBedecarrats/spatial-impact-evaluation.git # As initial

# Git
git clone $REPO_URL $WORK_DIR
chown -R onyxia:users $WORK_DIR

# copy files from S3 
mc cp -r s3/fbedecarrats/diffusion/cours_tana/data $WORK_DIR

# Again to give ritghs also in the data subfolder 
chown -R onyxia:users $WORK_DIR

# launch RStudio in the right project
# Copied from InseeLab UtilitR
    echo \
    "
    setHook('rstudio.sessionInit', function(newSession) {
        if (newSession && !identical(getwd(), \"'$WORK_DIR'\"))
        {
            message('On charge directement le bon projet :-) ')
            rstudioapi::openProject('$WORK_DIR')
            # For a slick dark theme
            rstudioapi::applyTheme('Merbivore')
            # Console where it should be
            rstudioapi::executeCommand('layoutConsoleOnRight')
            # To free the CTRL+Y shortcut for 'redo'
            }
            }, action = 'append')
            " >> /home/onyxia/work/.Rprofile
