FROM asilha/p4lang-behavioral-model:euclid

# Default to using 2 make jobs, which is a good default for CI. If you're
# building locally or you know there are more cores available, you may want to
# override this.
ARG MAKEFLAGS=-j2

# Select the type of image we're building. Use `build` for a normal build, which
# is optimized for image size. Use `test` if this image will be used for
# testing; in this case, the source code and build-only dependencies will not be
# removed from the image.
ARG IMAGE_TYPE=test

# Whether to do a unified build.
ARG ENABLE_UNIFIED_COMPILATION=ON
# Whether to enable translation validation
ARG VALIDATION=OFF
# This creates a release build that includes link time optimization and links
# all libraries statically.
ARG BUILD_STATIC_RELEASE=OFF

# Delegate the build to tools/ci-build.
COPY . /p4c/
WORKDIR /p4c/
RUN chmod u+x tools/ci-build.sh && tools/ci-build.sh
