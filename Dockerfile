FROM kasmweb/desktop:1.18.0-rolling-daily
USER root

ENV HOME=/home/kasm-default-profile
ENV STARTUPDIR=/dockerstartup
ENV INST_SCRIPTS=$STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

COPY ./src/comfyui $INST_SCRIPTS/comfyui/
RUN bash $INST_SCRIPTS/comfyui/install_comfyui.sh  && rm -rf $INST_SCRIPTS/comfyui/

COPY ./src/comfyui/custom_startup.sh $STARTUPDIR/custom_startup.sh
RUN chmod +x $STARTUPDIR/custom_startup.sh
COPY ./src/comfyui/launcher.sh /opt/ComfyUI/launcher.sh
RUN chmod +x /opt/ComfyUI/launcher.sh
RUN chown 1000:1000 /opt/ComfyUI/launcher.sh
COPY ./src/comfyui/comfyui.png /opt/ComfyUI/comfyui.png
RUN chown 1000:1000 /opt/ComfyUI/comfyui.png


RUN apt-get update && apt-get install -y gimp nomacs && cp /usr/share/applications/gimp.desktop $HOME/Desktop/ && chmod +x $HOME/Desktop/gimp.desktop

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME=/home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000