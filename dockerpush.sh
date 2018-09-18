eval $(aws ecr get-login --no-include-email --region us-east-1)
docker tag spring3hibernate:latest 969999170783.dkr.ecr.us-east-1.amazonaws.com/myrepo:latest
docker push 969999170783.dkr.ecr.us-east-1.amazonaws.com/myrepo:latest
