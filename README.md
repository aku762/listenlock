# PowerShell Lock Listener 🔒

Because sometimes you want to smack a button on an Arduino across the room and have your workstation slam-shut **right now**.

## What is this?

A quick PowerShell script that spins up a bare-bones `HttpListener`.  
Hit `http://<your-pc>:8080/lock` with an HTTP GET request and Windows calls `rundll32.exe user32.dll,LockWorkStation` —instantly locking the session.

Perfect for hardware shenanigans or any quick-and-dirty network trigger where “security theatre” isn’t the point, speed is.

## Quick Start

```powershell
# 1. Edit the listener address if needed:
$listenerPrefix = "http://0.0.0.0:8080/"

# 2. Run with elevated privileges:
powershell -ExecutionPolicy Bypass -File .\listenlock.ps1
````

Then from **any** device on the network:

```bash
curl http://YOUR-PC:8080/lock
```

*PC locks. Mission accomplished.*

## Why?

* Use an Ethernet-shielded Arduino or other MCU to hit this endpoint from a big red “LOCK” button.
* Testing serial-to-network bridges for a master’s thesis on CLI automation.
* Proving that sometimes the simplest tool in the box (PowerShell) still does the job.

## Caveats & Common Sense

* **Runs in the clear.** No TLS, no auth—keep it on a trusted LAN or wrap it with a reverse proxy.
* Needs **admin** rights to reserve an HTTP namespace or run under an elevated session.
* Hard-coded IP? Change `$listenerPrefix` to whatever interface/port suits you.

## License

MIT. Use, hack, break, improve—just don’t blame me if you lock yourself out mid-presentation.

---

*Old-school practicality meets maker-grade ingenuity. Have fun, and keep those screens locked.* ✌️
