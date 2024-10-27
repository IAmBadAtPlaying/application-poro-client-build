#!/bin/sh

# Clone and build frontend
clear
echo "Handling Frontend"
if [ -d "application-poro-client-frontend" ]; then
  echo "Repo already present, will not clone!"
  cd application-poro-client-frontend || exit
  git pull origin master
  sleep 2s
else
  echo "Cloning FE Repository"
  git clone https://github.com/IAmBadAtPlaying/application-poro-client-frontend
  sleep 2s
  cd application-poro-client-frontend || exit
fi
if [ -d "out" ]; then
  echo "Directory out exists. Deleting..."
  rm -rf out
else
  echo "Directory out does not exist. Skipping cleanup"
fi
echo "Running npm install"
npm install
echo "Running npm audit fix"
npm audit fix
echo "Running npm build"
npm run build
echo "Frontend done"

# Clone and build backend
cd /app || exit
echo "Handling Backend"
if [ -d "application-poro-client" ]; then
	echo "Repo already present, will not clone!"
	cd application-poro-client || exit
	git pull origin master
	sleep 2s
else
	echo "Cloning BE Repository"
	git clone https://github.com/IAmBadAtPlaying/application-poro-client.git
	sleep 2s
	cd application-poro-client || exit
fi
# Copy the built frontend to the backend resources folder
cp -r /app/poro-client-frontend/out/* /app/Poro-Client/src/main/resources/html/

# Build the backend
mvn clean package
echo "Build script done!"
