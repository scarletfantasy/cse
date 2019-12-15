sudo docker network create --subnet=172.20.0.0/16 ss
sudo docker run -d --net ss --ip 172.20.0.2 dplsming/sockshop-cataloguedb:0.1
sleep 2
sudo docker run -d --net ss --ip 172.20.0.3 mongo:3.4
sleep 2
sudo docker run -d --net ss --ip 172.20.0.4 --add-host catalogue-db:172.20.0.2 weaveworksdemos/catalogue:0.3.5
sleep 2
sudo docker run -d --net ss --ip 172.20.0.5  weaveworksdemos/shipping:0.4.8
sleep 2
sudo docker run -d --net ss --ip 172.20.0.6  weaveworksdemos/payment:0.4.3
sleep 2
sudo docker run -d --net ss --ip 172.20.0.7 --add-host  user-db:172.20.0.3 --add-host  carts:172.20.0.8 -e  MONGO_HOST=user-db:27017 weaveworksdemos/user:0.4.4 
sleep 2
sudo docker run -d --net ss --ip 172.20.0.8 --add-host  carts-db:172.20.0.3  --add-host  user:172.20.0.7 weaveworksdemos/carts:0.4.8
sleep 2
sudo docker run -d --net ss --ip 172.20.0.9 --add-host  orders-db:172.20.0.3   --add-host  user:172.20.0.7 --add-host  carts:172.20.0.8 --add-host  payment:172.20.0.6 --add-host  shipping:172.20.0.5  weaveworksdemos/orders:0.4.7
sleep 2
sudo docker run -d --net ss --ip 172.20.0.10  --add-host  catalogue:172.20.0.4 --add-host  orders:172.20.0.9   --add-host  user:172.20.0.7 --add-host  carts:172.20.0.8 --add-host  payment:172.20.0.6 --add-host  shipping:172.20.0.5   dplsming/sockshop-frontend:0.1
sleep 2
sudo docker run -d --net ss --ip 172.20.0.11  --add-host  catalogue:172.20.0.4 --add-host  orders:172.20.0.9   --add-host  user:172.20.0.7 --add-host  carts:172.20.0.8 --add-host  payment:172.20.0.6 --add-host  shipping:172.20.0.5   dplsming/sockshop-frontend:0.1
sleep 2
sudo docker run -d --net ss --ip 172.20.0.12  --add-host  catalogue:172.20.0.4 --add-host  orders:172.20.0.9   --add-host  user:172.20.0.7 --add-host  carts:172.20.0.8 --add-host  payment:172.20.0.6 --add-host  shipping:172.20.0.5   dplsming/sockshop-frontend:0.1
sleep 2
sudo docker run -d --net ss --ip 172.20.0.14 -v $(pwd)/conf.d:/etc/nginx/conf.d  -v  $(pwd)/frontend/public:/usr/public -p 12345:12345 nginx:latest

