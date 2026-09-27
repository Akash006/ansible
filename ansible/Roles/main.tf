- name: Test connectivity to target servers
  ping:
- name: Start ssh server
  service:
     name: sshd
     state: started
