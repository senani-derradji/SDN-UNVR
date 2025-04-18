# 📡 SDN-UNVR: Software-Defined Networking Controller System

A modular SDN lab setup using **Ryu**, **Mininet**, and **Wireshark**, designed for easy setup and control via shell scripts. Perfect for SDN learners and university projects.

---

## 📁 Project Structure

```
SDN-UNVR/
├── main_installer.sh         # Main script to install and manage services
├── ryu_control.sh            # Full Ryu controller launch script
├── ryu_lite.sh               # Lightweight Ryu script
├── ovs_mininet.sh            # Mininet topology launch
├── wireshark_monitor.sh      # Wireshark monitoring interface
├── requirements.txt          # Python dependencies
├── LICENSE
├── .gitattributes
└── RYU-ENV/                  # Python virtual environment for Ryu
```

---

## ⚙️ Setup Instructions

```bash
chmod +x *.sh
./main_installer.sh
```

Follow on-screen prompts to install packages, set up `RYU-ENV`, and start services.

---

## 🧪 Running Individually

```bash
source RYU-ENV/bin/activate
./ryu_control.sh
./ovs_mininet.sh
sudo ./wireshark_monitor.sh
```

Or use `ryu_lite.sh` for a minimal Ryu setup.

---

## 📦 RYU-ENV

Virtual Python environment auto-generated by the installer:
- Contains Ryu and all dependencies.
- Configured via `requirements.txt`.

---

## 👨‍💻 Author

**Derradji Senani**  
Master’s Student | Cloud, SDN & DevOps Enthusiast  
Batna, Algeria

---

> Built for universities and SDN enthusiasts to simulate, analyze, and monitor OpenFlow-based networks with ease.
