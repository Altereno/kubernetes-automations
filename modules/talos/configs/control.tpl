machine:
  kubelet:
    extraMounts:
      - destination: /var/lib/longhorn
        type: bind
        source: /var/lib/longhorn
        options:
          - bind
          - rshared
          - rw
  install:
    disk: /dev/vda
  network:
    interfaces:
      - interface: eth0
        vip:
          ip: ${vip_ip}
cluster:
  network:
    cni:
      name: none
  proxy:
    disabled: true
