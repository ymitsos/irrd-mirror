/*CREATE DATABASE irrd;
CREATE ROLE irrd WITH LOGIN ENCRYPTED PASSWORD 'irrd';*/
GRANT ALL PRIVILEGES ON DATABASE irrd TO irrd;
\c irrd
CREATE EXTENSION IF NOT EXISTS pgcrypto;
