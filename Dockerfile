FROM rocker/tidyverse:4.4.0
LABEL maintainer="Corrado Lanera <corrado.lanera@ubep.unipd.it>"

# https://notes.rmhogervorst.nl/post/2020/09/23/solving-libxt-so-6-cannot-open-shared-object-in-grdevices-grsoftversion/
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  libxt6 \
  libnng-dev cmake \
  libpoppler-cpp-dev \
  libtesseract-dev libleptonica-dev tesseract-ocr-eng \
  libv8-dev \
  xz-utils

RUN mkdir /home/rstudio/jecfa && chown -c rstudio /home/rstudio/jecfa
WORKDIR /home/rstudio/jecfa

COPY --chown=rstudio:rstudio . /home/rstudio/jecfa

USER rstudio
RUN R -e "renv::restore()"
USER root

EXPOSE 18187

CMD ["/init"]
