FROM rocker/shiny:4.4.1

RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev libssl-dev libxml2-dev libgit2-dev \
    libfreetype6-dev libpng-dev libjpeg-dev libcairo2-dev libharfbuzz-dev libfribidi-dev \
    && rm -rf /var/lib/apt/lists/*

COPY . /srv/shiny-server/cyclestats

RUN R -e "\
    options(repos = c(CRAN = 'https://p3m.dev/cran/__linux__/jammy/latest'));\
    install.packages('pak');\
    pak::pkg_install('/srv/shiny-server/cyclestats')\
"

RUN cat > /srv/shiny-server/cyclestats/app.R << 'EOF'
if (interactive()) {
  pkgload::load_all()
  cyclestats::cyclestatsApp()
} else {
  library(cyclestats)
  shiny::shinyApp(ui = cyclestats_ui, server = cyclestats_server)
}
EOF

CMD ["/usr/bin/shiny-server"]
