# Dairy of the project:

## Day 1:

- Creating kanban board
- Clone the repo
- Creating task.md
- test

## Day 2:

- Revising previous labs
- Pushing an image to docker hub

### Issues
Problems pushing an image. Solution : changing the order of deployment commands


## Day 3:
- Sucssfully tested front-end , orders , payment , shipping 

### Issues
- payment didn't work untill adding /main 
- getting badgetay with edge-router
- not working db in catalogue & orders 
- lack of sleep

## Day 4:
-user worked with makefile ( dockerdev , dockertestdb ,dockerruntest ) locally
- stuck with an error forever ( submodule test ) > fix delete test dir

### Issues 
-queue master didn't work until I changed jdk image, got queue-master-rabbitmq err
-load test didn't work because it needed python 3.6 or higher and updating pip and change locustio to locust , got error : "
TARGET_HOST is not set; use '-h hostname:port'"

## Day 5:
- fixing yestarday error :D 
- sucessfully pushing images using tekton 


### Issues 
- errors in catalogue , orders , q-master , shipping ) images, will try to work on it tmw and add the trello screenshots :) , good night , or good morning ( 4:00 am )


## Day 6:
-pushed all images by fixing the errors

### Issues 
- The weekend is a weekend

## Day 7:
- Run a sandbox
- Done with tekton 

## Day 8 & 9 (who's counting anyway):

- Pushed user-db & catalouge-db images 
- Deployed all the services 

### Issues
- Forgot to install ingress
- Front-end security needed to be deleted
- Catalouge wasn't working because of ingress
- User didn't work without cluser but worked in it ( porting issue I belive)
- Some services is hard to know if they are working such as queue master 
- There was so many errors more than I can remember :D 

## Day 10:

-elf and grafana working , all services working , e2e test is a big failure :)

## Day 12:
- working on e2e test and reading it to understand it 

### Issues
- still most of it errors 

## Day 13:
- same as yesterday  

## Day 14:
- working on the makefile

## Day 15:
- working on the makefile

## Day 16:
- added pipelines,Pieplines ,PipelineResource, task , taskrun for e2e-test and editing the image 

### Issues
- not passing yet

## Day 17:
- Test FINALLY pass

## Day 18:
- merged deploy files to one to be able to use it to deploy it to prod
- added generateName
- tried to deploy to prod 
- edited makefile

## Day 19:
- WORKED !!! deploying to prod

## Day 20:
- working on elf & grafana 
