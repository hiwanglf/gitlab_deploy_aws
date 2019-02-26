# gitlab_deploy_aws
# AWS上部署gitlab
参照文档：
https://docs.gitlab.com/ee/install/aws/index.html
![image](http://note.youdao.com/yws/res/4444/6FD16BA3A7A046DABB1377ACCFE939A1)
## 一、创建IAM EC2 示例角色role
1. 进入IAM面板
2. 创建角色，配置权限，选择：AmazonEC2FullAccess 和AmazonS3FullAccess,
3. 名称： GitLabAdmin


## 二、配置网络

### 2.1 创建VPC

### 2.2 子网设置

### 2.3 路由表设置

### 2.4 网关设置

### 2.5在路由表中配置子网

### 2.6 创建vpc的安全组

## 三、创建数据库PostgreSQL with RDS

### 3.1 RDS子网组

### 3.2 创建数据库

### 3.3 数据库扩展安装

## 四、Redis设置

### 4.1 子网设置

### 4.2 redis设置

## 五、ELB设置

## 六、使用auto scaling group部署gitlab

## 七、修改ELB相关信息
