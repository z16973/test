#!/bin/sh

# Download and install V2Ray
mkdir /tmp/v2ray
curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip /tmp/v2ray/v2ray.zip -d /tmp/ruby2
install -m 755 /tmp/ruby2/v2ray /usr/local/bin/ruby2
install -m 755 /tmp/ruby2/v2ctl /usr/local/bin/v2ctl

# Remove temporary directory
rm -rf /tmp/v2ray
rm -rf /tmp/ruby2

# V2Ray new configuration
install -d /usr/local/etc/ruby2
cat << EOF > /usr/local/etc/ruby2/config.json
{
    "inbounds": [
        {
            "port": 8080,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "ad806487-2d26-4636-98b6-ab85cc8521f7",
                        "alterId": 64
                    }
                ],
                "disableInsecureEncryption": true
            },
            "streamSettings": {
                "network": "ws"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

# Run V2Ray
/usr/local/bin/ruby2 -config /usr/local/etc/ruby2/config.json
