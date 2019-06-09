# Define the Build Phase
FROM node:alpine as Build_Phase

WORKDIR '/usr/app'

COPY package.json .

RUN npm install

# dependencies missing from node image
RUN npm install -gd express-generator
RUN npm install --save express

# In production environment, copy all source files
COPY . .

RUN npm run build

# Define the Run Phase
# For a complete list of available public docker image, see hub.docker.com
FROM nginx

COPY --from=Build_Phase /usr/app/build /usr/share/nginx/html

# Run is automatically part of the container