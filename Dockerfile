FROM jupyter/scipy-notebook:latest

# Create a Python 2.x environment using conda including at least the ipython kernel
# and the kernda utility.
RUN conda create --quiet --yes -p $CONDA_DIR/envs/python2 python=2.7 ipython kernda ipykernel && \
    conda clean -tipsy

USER root

# Create a global kernelspec in the image and modify it so that it properly activates
# the python2 conda environment.
RUN $CONDA_DIR/envs/python2/bin/python -m ipykernel install && \
    $CONDA_DIR/envs/python2/bin/kernda -o -y /usr/local/share/jupyter/kernels/python2/kernel.json

USER $NB_USER

RUN /bin/bash -c "touch requirements.txt"
RUN /bin/bash -c "echo tensorflow==0.12.0 >> requirements.txt"
RUN /bin/bash -c "echo pandas==0.19.2 >> requirements.txt"
RUN /bin/bash -c "echo scipy==0.18.1 >> requirements.txt"
RUN /bin/bash -c "echo scikit-learn==0.18.1 >> requirements.txt"
RUN /bin/bash -c "echo nltk==3.2.2 >> requirements.txt"
RUN /bin/bash -c "echo matplotlib==1.5.3 >> requirements.txt"

ENV PATH /opt/conda/envs/python2/bin:$PATH

RUN /bin/bash -c "pip --version"
RUN pip install -r requirements.txt