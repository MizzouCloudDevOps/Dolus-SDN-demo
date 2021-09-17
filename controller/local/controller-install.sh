# Pull and run docker image for controller
sudo docker pull mizzouceri/dolus-controller:latest
sudo docker run -dit -p 80:80 -p 6633:6633 -p 3306:3306 -p 33060:33060 --name controller mizzouceri/dolus-controller:latest
sudo docker exec -it controller service apache2 start
sudo docker exec -it controller service mysql start
