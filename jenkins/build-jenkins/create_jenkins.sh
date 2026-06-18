# 1. descarca ultima imagine de jenkins
docker pull jenkins/jenkins:lts

# 2. se creeaza un volum persistent
docker volume create jenkins-vol

# 3. build jenkins container 
docker run -d \
  --name jenkins-ctn \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins-vol:/var/jenkins_home \
  jenkins/jenkins:lts

  # 4. parola implicita
docker exec jenkins-ctn cat /var/jenkins_home/secrets/initialAdminPassword

docker exec -it jenkins-ctn bash