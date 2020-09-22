CREATE ROLE webtemplate WITH LOGIN PASSWORD 'webtemplate' CREATEDB;

CREATE DATABASE webtemplate_development;
CREATE DATABASE webtemplate_test;

GRANT ALL PRIVILEGES ON DATABASE "webtemplate_development" to webtemplate;
GRANT ALL PRIVILEGES ON DATABASE "webtemplate_test" to webtemplate;
