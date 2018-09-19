REPOSITORY_NAME=myrepo
CLUSTER=mycluster
FAMILY=spring3hibernate
NAME=spring3hibernate
SERVICE_NAME=springhibernate
SERVICES=`aws ecs describe-services --region ${REGION} --cluster ${CLUSTER} --services  ${SERVICE_NAME} | egrep  "DEPLOYMENTS" | awk '{print $3}' | wc -l`

INACTIVE_STATE=`aws ecs describe-services --region ${REGION}  --cluster ${CLUSTER} --services  ${SERVICE_NAME}  | grep 'INACTIVE' |wc -l`


TASK_REVISION=`aws ecs describe-task-definition --region ${REGION} --task-definition ${NAME} | egrep -i "TASKDEFINITION" | awk '{print $3}'`
echo -e "revision number is :${TASK_REVISION}"


echo -e "INACTIVE_STATE $INACTIVE_STATE"
echo -e "SERVICES $SERVICES"

if [ ${SERVICES} -eq 0 ] ; then

        echo "new service"
        aws ecs create-service --region ${REGION} --cluster ${CLUSTER} --service-name  ${SERVICE_NAME} --task-definition ${FAMILY}:${TASK_REVISION} --desired-count "2"
else
                if [ $INACTIVE_STATE -ne 0   ] ; then
                aws ecs create-service --region ${REGION} --cluster ${CLUSTER} --service-name  ${SERVICE_NAME} --task-definition ${FAMILY}:${TASK_REVISION} --desired-count "2"

                else
                                aws ecs update-service --region ${REGION} --cluster ${CLUSTER} --service  ${SERVICE_NAME} --task-definition ${FAMILY}:${TASK_REVISION} --desired-count 2


                fi

fi
