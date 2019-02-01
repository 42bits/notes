### 通过docker 安装gitlab
```
docker pull gitlab/gitlab-ce
```
```
cd ~
mkdir -p gitlab
cd gitlab

cat <<EOF > start.sh
#!/bin/bash
HOST_NAME=gitlab.example.com
GITLAB_DIR=`pwd`
docker stop gitlab
docker rm gitlab
docker run -d \\
    --hostname \${HOST_NAME} \\
    -p 8443:443 -p 8080:80 -p 2222:22 \\
    --name gitlab \\
    -v \${GITLAB_DIR}/config:/etc/gitlab \\
    -v \${GITLAB_DIR}/logs:/var/log/gitlab \\
    -v \${GITLAB_DIR}/data:/var/opt/gitlab \\
    gitlab/gitlab-ce:latest
EOF
```
```
vim /etc/hosts
127.0.0.1 gitlab.example.com
```
```
修改文件：${GITLAB_DIR}/config/gitlab.rb
找到这一行：# gitlab_rails['gitlab_shell_ssh_port'] = 22
把22修改为你的宿主机端口（这里是2222）。然后将注释去掉
```
```
sh start.sh
```
```
访问:
gitlab.example.com:8080
```
```
ssh配置
$ cat ~/.ssh/id_rsa.pub

#如果上一步没有这个文件 我们就创建一个，运行下面命令（邮箱改成自己的），一路回车就好了
$ ssh-keygen -t rsa -C "youremail@example.com"
$ cat ~/.ssh/id_rsa.pub
```

邮件
```
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "smtp.qq.com"
gitlab_rails['smtp_port'] = 465
gitlab_rails['smtp_user_name'] = "794686714@qq.com"
gitlab_rails['smtp_password'] = "dwfbzeckguecbbgb"
gitlab_rails['smtp_domain'] = "smtp.qq.com"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_tls'] = true
#gitlab_rails['smtp_openssl_verify_mode'] = 'peer'
gitlab_rails['gitlab_email_enabled'] = true
gitlab_rails['gitlab_email_from'] = '794686714@qq.com'
gitlab_rails['gitlab_email_display_name'] = 'Gitlab'

更新配置 gitlab-ctl reconfigure

测试:
gitlab-rails console

Notify.test_email('jshawcx@gmail.com', 'Message Subject', 'Message Body And Linuxea.com').deliver_now

```

gitlab-runner
```
sudo usermod -aG docker gitlab-runner
```