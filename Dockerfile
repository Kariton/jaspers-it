#####################################################################
#                            Build Stage                            #
#####################################################################
FROM hugomods/hugo:exts AS builder

ARG HUGO_ENV
ENV HUGO_ENV ${HUGO_ENV}
ARG HUGO_ENVIRONMENT
ENV HUGO_ENVIRONMENT ${HUGO_ENVIRONMENT}

COPY . /src
RUN hugo --gc --minify

# Generate pagefind index
RUN npm_config_yes=true npx pagefind

#####################################################################
#                              Deploy                              #
#####################################################################
FROM hugomods/hugo:nginx

COPY --from=builder /src/public /site
