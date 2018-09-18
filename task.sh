REGION=us-east-1
REPOSITORY_NAME=myrepo
CLUSTER=mycluster
FAMILY=spring3hibernate
NAME=spring3hibernate
SERVICE_NAME=spring3hibernatespring3hibernate-service
sed -e "s;%BUILD_NUMBER%;${BUILD_NUMBER};g" /home/ec2-user/tasktemplate.json > sample-v_${BUILD_NUMBER}.json
aws ecs register-task-definition --region ${REGION} --family ${FAMILY} --cli-input-json file://sample-v_${BUILD_NUMBER}.json
