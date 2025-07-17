# IRRd Docker Compose Stack

This repository provides a Docker Compose setup for running [IRRd](https://irrd.readthedocs.io/) (Internet Routing Registry Daemon) along with PostgreSQL and Redis aiming at mirroring locally IRR objects from certain RIR.

## ⚙️ Configuration Files

| File                | Description                                 |
| ------------------- | ------------------------------------------- |
| `configuration.env` | Contains environment variables for services |
| `init.sql`          | SQL initialization for PostgreSQL           |
| `config/`           | Configuration files for services            |

---

## 🔌 Ports

| Port | Service | Description       |
| ---- | ------- | ----------------- |
| 43   | irrd    | WHOIS TCP port    |
| 8080 | irrd    | HTTP API / Web UI |

---

## 📁 Environment Configuration

Modify the `configuration.env` file to meet your needs, with content similar to:

```env
POSTGRES_USER=irrd
POSTGRES_PASSWORD=your_secure_password
POSTGRES_DB=irrd
# Add additional IRRd configuration variables as needed
```

---

## ▶️ Usage

### Start the Stack

```bash
docker-compose up -d
```

### View Logs

```bash
docker-compose logs -f
```

### Stop the Stack

```bash
docker-compose down
```

---

## 📝 Notes

* Ensure `init.sql` and `configuration.env` are in the same directory as your `docker-compose.yml`.
* Ensure the files under config/ match your setup.
* Modify the `Dockerfile` and `entrypoint.sh` as needed to customize IRRd behavior.

---

## 📚 References

* [IRRd Documentation](https://irrd.readthedocs.io/)
* [PostgreSQL Image Docs](https://hub.docker.com/_/postgres)
* [Redis Image Docs](https://hub.docker.com/_/redis)
