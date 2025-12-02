--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY queueing.tbl_queued_customers DROP CONSTRAINT IF EXISTS tbl_queued_customers_i_queued_email_id_fkey;
ALTER TABLE IF EXISTS ONLY queueing.tbl_queued_click_throughs DROP CONSTRAINT IF EXISTS tbl_queued_click_throughs_i_queued_email_id_fkey;
ALTER TABLE IF EXISTS ONLY queueing.tbl_queued_click_through_records DROP CONSTRAINT IF EXISTS tbl_queued_click_through_records_i_queued_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY queueing.tbl_queued_click_through_records DROP CONSTRAINT IF EXISTS tbl_queued_click_through_records_i_queued_click_through_id_fkey;
ALTER TABLE IF EXISTS ONLY queueing.tbl_queued_attachments DROP CONSTRAINT IF EXISTS tbl_queued_attachments_i_email_id_fkey;
ALTER TABLE IF EXISTS ONLY emails.tbl_emails DROP CONSTRAINT IF EXISTS tbl_emails_i_company_id_fkey;
ALTER TABLE IF EXISTS ONLY emails.tbl_campaigns DROP CONSTRAINT IF EXISTS tbl_campaigns_i_email_id_fkey;
ALTER TABLE IF EXISTS ONLY emails.tbl_campaigns DROP CONSTRAINT IF EXISTS tbl_campaigns_i_company_id_fkey;
ALTER TABLE IF EXISTS ONLY emails.tbl_campaigns DROP CONSTRAINT IF EXISTS tbl_campaigns_i_company_email_address_id_fkey;
ALTER TABLE IF EXISTS ONLY emails.tbl_campaign_groups DROP CONSTRAINT IF EXISTS tbl_campaign_groups_i_group_id_fkey;
ALTER TABLE IF EXISTS ONLY emails.tbl_campaign_groups DROP CONSTRAINT IF EXISTS tbl_campaign_groups_i_campaign_id_fkey;
ALTER TABLE IF EXISTS ONLY emails.tbl_attachments DROP CONSTRAINT IF EXISTS tbl_attachments_i_campaign_id_fkey;
ALTER TABLE IF EXISTS ONLY customers.tbl_customers_companies DROP CONSTRAINT IF EXISTS tbl_customers_companies_i_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY customers.tbl_customers_companies DROP CONSTRAINT IF EXISTS tbl_customers_companies_i_company_id_fkey;
ALTER TABLE IF EXISTS ONLY customers.tbl_customer_groups DROP CONSTRAINT IF EXISTS tbl_customer_groups_i_company_id_fkey;
ALTER TABLE IF EXISTS ONLY customers.tbl_customer_group_members DROP CONSTRAINT IF EXISTS tbl_customer_group_members_i_group_id_fkey;
ALTER TABLE IF EXISTS ONLY customers.tbl_customer_group_members DROP CONSTRAINT IF EXISTS tbl_customer_group_members_i_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY companies.tbl_company_email_addresses DROP CONSTRAINT IF EXISTS tbl_company_email_addresses_i_company_id_fkey;
ALTER TABLE IF EXISTS ONLY companies.tbl_companies DROP CONSTRAINT IF EXISTS tbl_companies_i_country_fkey;
ALTER TABLE IF EXISTS ONLY queueing.tbl_queued_customers DROP CONSTRAINT IF EXISTS tbl_queued_customers_pkey;
ALTER TABLE IF EXISTS ONLY queueing.tbl_queued_click_throughs DROP CONSTRAINT IF EXISTS tbl_queued_click_throughs_pkey;
ALTER TABLE IF EXISTS ONLY queueing.tbl_queued_click_through_records DROP CONSTRAINT IF EXISTS tbl_queued_click_through_records_pkey;
ALTER TABLE IF EXISTS ONLY queueing.tbl_queued_attachments DROP CONSTRAINT IF EXISTS tbl_queued_attachments_pkey;
ALTER TABLE IF EXISTS ONLY queueing.tbl_queued_emails DROP CONSTRAINT IF EXISTS tbl_emails_pkey;
ALTER TABLE IF EXISTS ONLY emails.tbl_emails DROP CONSTRAINT IF EXISTS tbl_emails_pkey;
ALTER TABLE IF EXISTS ONLY emails.tbl_campaigns DROP CONSTRAINT IF EXISTS tbl_campaigns_pkey;
ALTER TABLE IF EXISTS ONLY emails.tbl_campaign_groups DROP CONSTRAINT IF EXISTS tbl_campaign_groups_pkey;
ALTER TABLE IF EXISTS ONLY emails.tbl_campaign_customers DROP CONSTRAINT IF EXISTS tbl_campaign_customers_pkey;
ALTER TABLE IF EXISTS ONLY emails.tbl_attachments DROP CONSTRAINT IF EXISTS tbl_attachments_pkey;
ALTER TABLE IF EXISTS ONLY customers.tbl_id_types DROP CONSTRAINT IF EXISTS tbl_id_types_pkey;
ALTER TABLE IF EXISTS ONLY customers.tbl_customers DROP CONSTRAINT IF EXISTS tbl_customers_pkey;
ALTER TABLE IF EXISTS ONLY customers.tbl_customers_companies DROP CONSTRAINT IF EXISTS tbl_customers_companies_pkey;
ALTER TABLE IF EXISTS ONLY customers.tbl_customer_groups DROP CONSTRAINT IF EXISTS tbl_customer_groups_pkey;
ALTER TABLE IF EXISTS ONLY customers.tbl_customer_group_members DROP CONSTRAINT IF EXISTS tbl_customer_group_members_pkey;
ALTER TABLE IF EXISTS ONLY companies.tbl_id_types DROP CONSTRAINT IF EXISTS tbl_id_types_pkey;
ALTER TABLE IF EXISTS ONLY companies.tbl_countries DROP CONSTRAINT IF EXISTS tbl_countries_pkey;
ALTER TABLE IF EXISTS ONLY companies.tbl_company_email_addresses DROP CONSTRAINT IF EXISTS tbl_company_email_addresses_pkey;
ALTER TABLE IF EXISTS ONLY companies.tbl_companies DROP CONSTRAINT IF EXISTS tbl_companies_pkey;
ALTER TABLE IF EXISTS ONLY authentication.tbl_users DROP CONSTRAINT IF EXISTS tbl_users_pkey;
ALTER TABLE IF EXISTS queueing.tbl_queued_emails ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS queueing.tbl_queued_customers ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS queueing.tbl_queued_click_throughs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS queueing.tbl_queued_click_through_records ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS queueing.tbl_queued_attachments ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS emails.tbl_emails ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS emails.tbl_campaigns ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS emails.tbl_campaign_groups ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS emails.tbl_campaign_customers ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS emails.tbl_attachments ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS customers.tbl_customers_companies ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS customers.tbl_customers ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS customers.tbl_customer_id_types ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS customers.tbl_customer_groups ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS customers.tbl_customer_group_members ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS companies.tbl_countries ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS companies.tbl_company_id_types ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS companies.tbl_company_email_addresses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS companies.tbl_companies ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS authentication.tbl_users ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS queueing.tbl_queued_customers_id_seq;
DROP TABLE IF EXISTS queueing.tbl_queued_customers;
DROP SEQUENCE IF EXISTS queueing.tbl_queued_click_throughs_id_seq;
DROP TABLE IF EXISTS queueing.tbl_queued_click_throughs;
DROP SEQUENCE IF EXISTS queueing.tbl_queued_click_through_records_id_seq;
DROP TABLE IF EXISTS queueing.tbl_queued_click_through_records;
DROP SEQUENCE IF EXISTS queueing.tbl_queued_attachments_id_seq;
DROP TABLE IF EXISTS queueing.tbl_queued_attachments;
DROP SEQUENCE IF EXISTS queueing.tbl_emails_id_seq;
DROP TABLE IF EXISTS queueing.tbl_queued_emails;
DROP SEQUENCE IF EXISTS public.tbl_email_addresses_id_seq;
DROP SEQUENCE IF EXISTS emails.tbl_emails_id_seq;
DROP TABLE IF EXISTS emails.tbl_emails;
DROP SEQUENCE IF EXISTS emails.tbl_campaigns_id_seq;
DROP TABLE IF EXISTS emails.tbl_campaigns;
DROP SEQUENCE IF EXISTS emails.tbl_campaign_groups_id_seq;
DROP TABLE IF EXISTS emails.tbl_campaign_groups;
DROP SEQUENCE IF EXISTS emails.tbl_campaign_customers_id_seq;
DROP TABLE IF EXISTS emails.tbl_campaign_customers;
DROP SEQUENCE IF EXISTS emails.tbl_attachments_id_seq;
DROP TABLE IF EXISTS emails.tbl_attachments;
DROP TABLE IF EXISTS customers.tbl_id_types;
DROP SEQUENCE IF EXISTS customers.tbl_id_types_id_seq;
DROP SEQUENCE IF EXISTS customers.tbl_customers_id_seq;
DROP SEQUENCE IF EXISTS customers.tbl_customers_companies_id_seq;
DROP TABLE IF EXISTS customers.tbl_customers_companies;
DROP TABLE IF EXISTS customers.tbl_customers;
DROP TABLE IF EXISTS customers.tbl_customer_id_types;
DROP SEQUENCE IF EXISTS customers.tbl_customer_groups_id_seq;
DROP TABLE IF EXISTS customers.tbl_customer_groups;
DROP SEQUENCE IF EXISTS customers.tbl_customer_group_members_id_seq;
DROP TABLE IF EXISTS customers.tbl_customer_group_members;
DROP TABLE IF EXISTS companies.tbl_id_types;
DROP SEQUENCE IF EXISTS companies.tbl_id_types_id_seq;
DROP SEQUENCE IF EXISTS companies.tbl_countries_id_seq;
DROP TABLE IF EXISTS companies.tbl_countries;
DROP TABLE IF EXISTS companies.tbl_company_id_types;
DROP SEQUENCE IF EXISTS companies.tbl_company_email_addresses_id_seq;
DROP TABLE IF EXISTS companies.tbl_company_email_addresses;
DROP SEQUENCE IF EXISTS companies.tbl_companies_id_seq;
DROP TABLE IF EXISTS companies.tbl_companies;
DROP SEQUENCE IF EXISTS authentication.tbl_users_id_seq;
DROP TABLE IF EXISTS authentication.tbl_users;
DROP EXTENSION IF EXISTS "uuid-ossp";
DROP SCHEMA IF EXISTS queueing;
DROP SCHEMA IF EXISTS emails;
DROP SCHEMA IF EXISTS customers;
DROP SCHEMA IF EXISTS companies;
DROP SCHEMA IF EXISTS authentication;
--
-- Name: authentication; Type: SCHEMA; Schema: -; Owner: bulkmail_user
--

CREATE SCHEMA authentication;


ALTER SCHEMA authentication OWNER TO bulkmail_user;

--
-- Name: companies; Type: SCHEMA; Schema: -; Owner: bulkmail_user
--

CREATE SCHEMA companies;


ALTER SCHEMA companies OWNER TO bulkmail_user;

--
-- Name: customers; Type: SCHEMA; Schema: -; Owner: bulkmail_user
--

CREATE SCHEMA customers;


ALTER SCHEMA customers OWNER TO bulkmail_user;

--
-- Name: emails; Type: SCHEMA; Schema: -; Owner: bulkmail_user
--

CREATE SCHEMA emails;


ALTER SCHEMA emails OWNER TO bulkmail_user;

--
-- Name: queueing; Type: SCHEMA; Schema: -; Owner: bulkmail_user
--

CREATE SCHEMA queueing;


ALTER SCHEMA queueing OWNER TO bulkmail_user;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: tbl_users; Type: TABLE; Schema: authentication; Owner: bulkmail_user
--

CREATE TABLE authentication.tbl_users (
    id integer NOT NULL,
    v_user_id character varying(64) DEFAULT ''::character varying NOT NULL,
    v_password character varying(255) DEFAULT ''::character varying NOT NULL,
    i_company_id integer DEFAULT 0 NOT NULL,
    bl_admin boolean DEFAULT false NOT NULL
);


ALTER TABLE authentication.tbl_users OWNER TO bulkmail_user;

--
-- Name: tbl_users_id_seq; Type: SEQUENCE; Schema: authentication; Owner: bulkmail_user
--

CREATE SEQUENCE authentication.tbl_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE authentication.tbl_users_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_users_id_seq; Type: SEQUENCE OWNED BY; Schema: authentication; Owner: bulkmail_user
--

ALTER SEQUENCE authentication.tbl_users_id_seq OWNED BY authentication.tbl_users.id;


--
-- Name: tbl_companies; Type: TABLE; Schema: companies; Owner: bulkmail_user
--

CREATE TABLE companies.tbl_companies (
    id integer NOT NULL,
    i_id_type integer DEFAULT 0 NOT NULL,
    v_registration_number character varying(128) DEFAULT ''::character varying NOT NULL,
    v_organisation_name character varying(128) DEFAULT ''::character varying NOT NULL,
    v_trading_name character varying(128) DEFAULT ''::character varying NOT NULL,
    d_registration_date date,
    v_contact_person character varying(128) DEFAULT ''::character varying NOT NULL,
    v_contact_person_alternate character varying(128) DEFAULT ''::character varying NOT NULL,
    v_email character varying(128) DEFAULT ''::character varying NOT NULL,
    v_email_alternate character varying(128) DEFAULT ''::character varying NOT NULL,
    v_mobile_number character varying(32) DEFAULT ''::character varying NOT NULL,
    v_mobile_number_alternate character varying(32) DEFAULT ''::character varying NOT NULL,
    v_landline_number character varying(32) DEFAULT ''::character varying NOT NULL,
    v_landline_number_alternate character varying(32) DEFAULT ''::character varying NOT NULL,
    v_additional_address character varying(128) DEFAULT ''::character varying NOT NULL,
    v_building_number_name character varying(128) DEFAULT ''::character varying NOT NULL,
    v_street_name character varying(128) DEFAULT ''::character varying NOT NULL,
    v_suburb character varying(128) DEFAULT ''::character varying NOT NULL,
    v_city character varying(128) DEFAULT ''::character varying NOT NULL,
    v_province character varying(128) DEFAULT ''::character varying NOT NULL,
    v_municipality character varying(128) DEFAULT ''::character varying NOT NULL,
    i_country integer DEFAULT 0 NOT NULL,
    v_code character varying(16) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE companies.tbl_companies OWNER TO bulkmail_user;

--
-- Name: tbl_companies_id_seq; Type: SEQUENCE; Schema: companies; Owner: bulkmail_user
--

CREATE SEQUENCE companies.tbl_companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE companies.tbl_companies_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: companies; Owner: bulkmail_user
--

ALTER SEQUENCE companies.tbl_companies_id_seq OWNED BY companies.tbl_companies.id;


--
-- Name: tbl_company_email_addresses; Type: TABLE; Schema: companies; Owner: bulkmail_user
--

CREATE TABLE companies.tbl_company_email_addresses (
    id integer NOT NULL,
    i_company_id integer DEFAULT 0 NOT NULL,
    v_email_address character varying(128) DEFAULT ''::character varying NOT NULL,
    v_reply_to_address character varying(128) DEFAULT ''::character varying NOT NULL,
    v_user_id character varying(128) DEFAULT ''::character varying NOT NULL,
    v_password character varying(128) DEFAULT ''::character varying NOT NULL,
    v_server_name character varying(128) DEFAULT ''::character varying NOT NULL,
    i_port integer DEFAULT 587 NOT NULL,
    bl_secure boolean DEFAULT true NOT NULL,
    bl_starttls boolean DEFAULT true NOT NULL
);


ALTER TABLE companies.tbl_company_email_addresses OWNER TO bulkmail_user;

--
-- Name: tbl_company_email_addresses_id_seq; Type: SEQUENCE; Schema: companies; Owner: bulkmail_user
--

CREATE SEQUENCE companies.tbl_company_email_addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE companies.tbl_company_email_addresses_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_company_email_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: companies; Owner: bulkmail_user
--

ALTER SEQUENCE companies.tbl_company_email_addresses_id_seq OWNED BY companies.tbl_company_email_addresses.id;


--
-- Name: tbl_company_id_types; Type: TABLE; Schema: companies; Owner: bulkmail_user
--

CREATE TABLE companies.tbl_company_id_types (
    id integer NOT NULL,
    v_description character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE companies.tbl_company_id_types OWNER TO bulkmail_user;

--
-- Name: tbl_countries; Type: TABLE; Schema: companies; Owner: bulkmail_user
--

CREATE TABLE companies.tbl_countries (
    id integer NOT NULL,
    v_country_code character varying(3) DEFAULT ''::character varying NOT NULL,
    v_country_name character varying(128) DEFAULT ''::character varying NOT NULL,
    v_dial_code character varying(16) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE companies.tbl_countries OWNER TO bulkmail_user;

--
-- Name: tbl_countries_id_seq; Type: SEQUENCE; Schema: companies; Owner: bulkmail_user
--

CREATE SEQUENCE companies.tbl_countries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE companies.tbl_countries_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_countries_id_seq; Type: SEQUENCE OWNED BY; Schema: companies; Owner: bulkmail_user
--

ALTER SEQUENCE companies.tbl_countries_id_seq OWNED BY companies.tbl_countries.id;


--
-- Name: tbl_id_types_id_seq; Type: SEQUENCE; Schema: companies; Owner: bulkmail_user
--

CREATE SEQUENCE companies.tbl_id_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE companies.tbl_id_types_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_id_types_id_seq; Type: SEQUENCE OWNED BY; Schema: companies; Owner: bulkmail_user
--

ALTER SEQUENCE companies.tbl_id_types_id_seq OWNED BY companies.tbl_company_id_types.id;


--
-- Name: tbl_id_types; Type: TABLE; Schema: companies; Owner: bulkmail_user
--

CREATE TABLE companies.tbl_id_types (
    id integer DEFAULT nextval('companies.tbl_id_types_id_seq'::regclass) NOT NULL,
    v_description character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE companies.tbl_id_types OWNER TO bulkmail_user;

--
-- Name: tbl_customer_group_members; Type: TABLE; Schema: customers; Owner: bulkmail_user
--

CREATE TABLE customers.tbl_customer_group_members (
    id integer NOT NULL,
    i_customer_id integer DEFAULT 0 NOT NULL,
    i_group_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE customers.tbl_customer_group_members OWNER TO bulkmail_user;

--
-- Name: tbl_customer_group_members_id_seq; Type: SEQUENCE; Schema: customers; Owner: bulkmail_user
--

CREATE SEQUENCE customers.tbl_customer_group_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE customers.tbl_customer_group_members_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_customer_group_members_id_seq; Type: SEQUENCE OWNED BY; Schema: customers; Owner: bulkmail_user
--

ALTER SEQUENCE customers.tbl_customer_group_members_id_seq OWNED BY customers.tbl_customer_group_members.id;


--
-- Name: tbl_customer_groups; Type: TABLE; Schema: customers; Owner: bulkmail_user
--

CREATE TABLE customers.tbl_customer_groups (
    id integer NOT NULL,
    i_company_id integer DEFAULT 0 NOT NULL,
    v_group_name character varying(64) DEFAULT ''::character varying NOT NULL,
    v_description character varying(128) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE customers.tbl_customer_groups OWNER TO bulkmail_user;

--
-- Name: tbl_customer_groups_id_seq; Type: SEQUENCE; Schema: customers; Owner: bulkmail_user
--

CREATE SEQUENCE customers.tbl_customer_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE customers.tbl_customer_groups_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_customer_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: customers; Owner: bulkmail_user
--

ALTER SEQUENCE customers.tbl_customer_groups_id_seq OWNED BY customers.tbl_customer_groups.id;


--
-- Name: tbl_customer_id_types; Type: TABLE; Schema: customers; Owner: bulkmail_user
--

CREATE TABLE customers.tbl_customer_id_types (
    id integer NOT NULL,
    v_description character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE customers.tbl_customer_id_types OWNER TO bulkmail_user;

--
-- Name: tbl_customers; Type: TABLE; Schema: customers; Owner: bulkmail_user
--

CREATE TABLE customers.tbl_customers (
    id integer NOT NULL,
    i_id_type integer DEFAULT 0 NOT NULL,
    v_id_number character varying(64) DEFAULT ''::character varying NOT NULL,
    v_title character varying(32) DEFAULT ''::character varying NOT NULL,
    v_first_names character varying(128) DEFAULT ''::character varying NOT NULL,
    v_last_name character varying(128) DEFAULT ''::character varying NOT NULL,
    v_gender character varying(8) DEFAULT ''::character varying NOT NULL,
    v_nationality character varying(128) DEFAULT ''::character varying NOT NULL,
    v_mobile_number character varying(64) DEFAULT ''::character varying NOT NULL,
    v_mobile_number_alternate character varying(64) DEFAULT ''::character varying NOT NULL,
    v_landline_number character varying(64) DEFAULT ''::character varying NOT NULL,
    v_landline_number_alternate character varying(64) DEFAULT ''::character varying NOT NULL,
    v_email character varying(128) DEFAULT ''::character varying NOT NULL,
    v_email_alternate character varying(128) DEFAULT ''::character varying NOT NULL,
    v_address character varying(64) DEFAULT ''::character varying NOT NULL,
    v_street_name character varying(64) DEFAULT ''::character varying NOT NULL,
    v_suburb character varying(64) DEFAULT ''::character varying NOT NULL,
    v_city character varying(64) DEFAULT ''::character varying NOT NULL,
    v_province character varying(64) DEFAULT ''::character varying NOT NULL,
    v_postal_code character varying(32) DEFAULT ''::character varying NOT NULL,
    v_postal_address character varying(128) DEFAULT ''::character varying NOT NULL,
    bl_email_issue boolean DEFAULT false NOT NULL
);


ALTER TABLE customers.tbl_customers OWNER TO bulkmail_user;

--
-- Name: tbl_customers_companies; Type: TABLE; Schema: customers; Owner: bulkmail_user
--

CREATE TABLE customers.tbl_customers_companies (
    id integer NOT NULL,
    i_customer_id integer DEFAULT 0 NOT NULL,
    i_company_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE customers.tbl_customers_companies OWNER TO bulkmail_user;

--
-- Name: tbl_customers_companies_id_seq; Type: SEQUENCE; Schema: customers; Owner: bulkmail_user
--

CREATE SEQUENCE customers.tbl_customers_companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE customers.tbl_customers_companies_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_customers_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: customers; Owner: bulkmail_user
--

ALTER SEQUENCE customers.tbl_customers_companies_id_seq OWNED BY customers.tbl_customers_companies.id;


--
-- Name: tbl_customers_id_seq; Type: SEQUENCE; Schema: customers; Owner: bulkmail_user
--

CREATE SEQUENCE customers.tbl_customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE customers.tbl_customers_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_customers_id_seq; Type: SEQUENCE OWNED BY; Schema: customers; Owner: bulkmail_user
--

ALTER SEQUENCE customers.tbl_customers_id_seq OWNED BY customers.tbl_customers.id;


--
-- Name: tbl_id_types_id_seq; Type: SEQUENCE; Schema: customers; Owner: bulkmail_user
--

CREATE SEQUENCE customers.tbl_id_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE customers.tbl_id_types_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_id_types_id_seq; Type: SEQUENCE OWNED BY; Schema: customers; Owner: bulkmail_user
--

ALTER SEQUENCE customers.tbl_id_types_id_seq OWNED BY customers.tbl_customer_id_types.id;


--
-- Name: tbl_id_types; Type: TABLE; Schema: customers; Owner: bulkmail_user
--

CREATE TABLE customers.tbl_id_types (
    id integer DEFAULT nextval('customers.tbl_id_types_id_seq'::regclass) NOT NULL,
    v_description character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE customers.tbl_id_types OWNER TO bulkmail_user;

--
-- Name: tbl_attachments; Type: TABLE; Schema: emails; Owner: bulkmail_user
--

CREATE TABLE emails.tbl_attachments (
    id integer NOT NULL,
    v_file_name character varying(128) DEFAULT ''::character varying NOT NULL,
    v_mime_type character varying(128) DEFAULT ''::character varying NOT NULL,
    b_file bytea NOT NULL,
    i_campaign_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE emails.tbl_attachments OWNER TO bulkmail_user;

--
-- Name: tbl_attachments_id_seq; Type: SEQUENCE; Schema: emails; Owner: bulkmail_user
--

CREATE SEQUENCE emails.tbl_attachments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE emails.tbl_attachments_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: emails; Owner: bulkmail_user
--

ALTER SEQUENCE emails.tbl_attachments_id_seq OWNED BY emails.tbl_attachments.id;


--
-- Name: tbl_campaign_customers; Type: TABLE; Schema: emails; Owner: bulkmail_user
--

CREATE TABLE emails.tbl_campaign_customers (
    id integer NOT NULL,
    i_campaign_id integer DEFAULT 0 NOT NULL,
    i_customer_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE emails.tbl_campaign_customers OWNER TO bulkmail_user;

--
-- Name: tbl_campaign_customers_id_seq; Type: SEQUENCE; Schema: emails; Owner: bulkmail_user
--

CREATE SEQUENCE emails.tbl_campaign_customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE emails.tbl_campaign_customers_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_campaign_customers_id_seq; Type: SEQUENCE OWNED BY; Schema: emails; Owner: bulkmail_user
--

ALTER SEQUENCE emails.tbl_campaign_customers_id_seq OWNED BY emails.tbl_campaign_customers.id;


--
-- Name: tbl_campaign_groups; Type: TABLE; Schema: emails; Owner: bulkmail_user
--

CREATE TABLE emails.tbl_campaign_groups (
    id integer NOT NULL,
    i_campaign_id integer DEFAULT 0 NOT NULL,
    i_group_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE emails.tbl_campaign_groups OWNER TO bulkmail_user;

--
-- Name: tbl_campaign_groups_id_seq; Type: SEQUENCE; Schema: emails; Owner: bulkmail_user
--

CREATE SEQUENCE emails.tbl_campaign_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE emails.tbl_campaign_groups_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_campaign_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: emails; Owner: bulkmail_user
--

ALTER SEQUENCE emails.tbl_campaign_groups_id_seq OWNED BY emails.tbl_campaign_groups.id;


--
-- Name: tbl_campaigns; Type: TABLE; Schema: emails; Owner: bulkmail_user
--

CREATE TABLE emails.tbl_campaigns (
    id integer NOT NULL,
    i_company_id integer DEFAULT 0 NOT NULL,
    v_campaign_title character varying(128) DEFAULT ''::character varying NOT NULL,
    v_description character varying(512) DEFAULT ''::character varying NOT NULL,
    i_email_id integer DEFAULT 0 NOT NULL,
    dt_target timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    v_email_from character varying(128) DEFAULT ''::character varying NOT NULL,
    v_email_reply_to character varying(128) DEFAULT ''::character varying NOT NULL,
    v_reference_number character varying(64) DEFAULT ''::character varying NOT NULL,
    i_company_email_address_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE emails.tbl_campaigns OWNER TO bulkmail_user;

--
-- Name: tbl_campaigns_id_seq; Type: SEQUENCE; Schema: emails; Owner: bulkmail_user
--

CREATE SEQUENCE emails.tbl_campaigns_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE emails.tbl_campaigns_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_campaigns_id_seq; Type: SEQUENCE OWNED BY; Schema: emails; Owner: bulkmail_user
--

ALTER SEQUENCE emails.tbl_campaigns_id_seq OWNED BY emails.tbl_campaigns.id;


--
-- Name: tbl_emails; Type: TABLE; Schema: emails; Owner: bulkmail_user
--

CREATE TABLE emails.tbl_emails (
    id integer NOT NULL,
    v_title character varying(128) DEFAULT ''::character varying NOT NULL,
    v_subject character varying(128) DEFAULT ''::character varying NOT NULL,
    t_body text DEFAULT ''::text NOT NULL,
    i_company_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE emails.tbl_emails OWNER TO bulkmail_user;

--
-- Name: tbl_emails_id_seq; Type: SEQUENCE; Schema: emails; Owner: bulkmail_user
--

CREATE SEQUENCE emails.tbl_emails_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE emails.tbl_emails_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_emails_id_seq; Type: SEQUENCE OWNED BY; Schema: emails; Owner: bulkmail_user
--

ALTER SEQUENCE emails.tbl_emails_id_seq OWNED BY emails.tbl_emails.id;


--
-- Name: tbl_email_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: bulkmail_user
--

CREATE SEQUENCE public.tbl_email_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.tbl_email_addresses_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_queued_emails; Type: TABLE; Schema: queueing; Owner: bulkmail_user
--

CREATE TABLE queueing.tbl_queued_emails (
    id integer NOT NULL,
    v_subject character varying(128) DEFAULT ''::character varying NOT NULL,
    t_body text DEFAULT ''::text NOT NULL,
    i_company_id integer DEFAULT 0 NOT NULL,
    i_campaign_id integer DEFAULT 0 NOT NULL,
    dt_target timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    v_email_from character varying(128) DEFAULT ''::character varying NOT NULL,
    v_email_reply_to character varying(128) DEFAULT ''::character varying NOT NULL,
    v_reference_number character varying(64) DEFAULT ''::character varying NOT NULL,
    bl_done boolean DEFAULT false NOT NULL,
    bl_active boolean DEFAULT true NOT NULL,
    dt_processed timestamp without time zone,
    v_result character varying(128) DEFAULT ''::character varying NOT NULL,
    v_user_id character varying(128) DEFAULT ''::character varying NOT NULL,
    v_password character varying(128) DEFAULT ''::character varying NOT NULL,
    v_server_name character varying(128) DEFAULT ''::character varying NOT NULL,
    i_port integer DEFAULT 587 NOT NULL,
    bl_secure boolean DEFAULT true NOT NULL,
    bl_starttls boolean DEFAULT true NOT NULL,
    dt_started timestamp without time zone
);


ALTER TABLE queueing.tbl_queued_emails OWNER TO bulkmail_user;

--
-- Name: tbl_emails_id_seq; Type: SEQUENCE; Schema: queueing; Owner: bulkmail_user
--

CREATE SEQUENCE queueing.tbl_emails_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE queueing.tbl_emails_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_emails_id_seq; Type: SEQUENCE OWNED BY; Schema: queueing; Owner: bulkmail_user
--

ALTER SEQUENCE queueing.tbl_emails_id_seq OWNED BY queueing.tbl_queued_emails.id;


--
-- Name: tbl_queued_attachments; Type: TABLE; Schema: queueing; Owner: bulkmail_user
--

CREATE TABLE queueing.tbl_queued_attachments (
    id integer NOT NULL,
    i_queued_email_id integer DEFAULT 0 NOT NULL,
    v_file_name character varying(128) DEFAULT ''::character varying NOT NULL,
    v_mime_type character varying(128) DEFAULT ''::character varying NOT NULL,
    b_file bytea NOT NULL
);


ALTER TABLE queueing.tbl_queued_attachments OWNER TO bulkmail_user;

--
-- Name: tbl_queued_attachments_id_seq; Type: SEQUENCE; Schema: queueing; Owner: bulkmail_user
--

CREATE SEQUENCE queueing.tbl_queued_attachments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE queueing.tbl_queued_attachments_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_queued_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: queueing; Owner: bulkmail_user
--

ALTER SEQUENCE queueing.tbl_queued_attachments_id_seq OWNED BY queueing.tbl_queued_attachments.id;


--
-- Name: tbl_queued_click_through_records; Type: TABLE; Schema: queueing; Owner: bulkmail_user
--

CREATE TABLE queueing.tbl_queued_click_through_records (
    id integer NOT NULL,
    i_queued_click_through_id integer DEFAULT 0 NOT NULL,
    i_queued_customer_id integer DEFAULT 0 NOT NULL,
    si_count smallint DEFAULT '0'::smallint NOT NULL,
    dt_last timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE queueing.tbl_queued_click_through_records OWNER TO bulkmail_user;

--
-- Name: tbl_queued_click_through_records_id_seq; Type: SEQUENCE; Schema: queueing; Owner: bulkmail_user
--

CREATE SEQUENCE queueing.tbl_queued_click_through_records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE queueing.tbl_queued_click_through_records_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_queued_click_through_records_id_seq; Type: SEQUENCE OWNED BY; Schema: queueing; Owner: bulkmail_user
--

ALTER SEQUENCE queueing.tbl_queued_click_through_records_id_seq OWNED BY queueing.tbl_queued_click_through_records.id;


--
-- Name: tbl_queued_click_throughs; Type: TABLE; Schema: queueing; Owner: bulkmail_user
--

CREATE TABLE queueing.tbl_queued_click_throughs (
    id integer NOT NULL,
    i_queued_email_id integer DEFAULT 0 NOT NULL,
    v_destination_url character varying(256) DEFAULT ''::character varying NOT NULL,
    u_identify uuid NOT NULL
);


ALTER TABLE queueing.tbl_queued_click_throughs OWNER TO bulkmail_user;

--
-- Name: tbl_queued_click_throughs_id_seq; Type: SEQUENCE; Schema: queueing; Owner: bulkmail_user
--

CREATE SEQUENCE queueing.tbl_queued_click_throughs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE queueing.tbl_queued_click_throughs_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_queued_click_throughs_id_seq; Type: SEQUENCE OWNED BY; Schema: queueing; Owner: bulkmail_user
--

ALTER SEQUENCE queueing.tbl_queued_click_throughs_id_seq OWNED BY queueing.tbl_queued_click_throughs.id;


--
-- Name: tbl_queued_customers; Type: TABLE; Schema: queueing; Owner: bulkmail_user
--

CREATE TABLE queueing.tbl_queued_customers (
    id integer NOT NULL,
    v_first_names character varying(128) DEFAULT ''::character varying NOT NULL,
    v_last_name character varying(128) DEFAULT ''::character varying NOT NULL,
    v_mobile_number character varying(64) DEFAULT ''::character varying NOT NULL,
    v_email character varying(128) DEFAULT ''::character varying NOT NULL,
    i_queued_email_id integer DEFAULT 0 NOT NULL,
    bl_success boolean,
    v_reason character varying(256) DEFAULT ''::character varying NOT NULL,
    v_title character varying(32) DEFAULT ''::character varying NOT NULL,
    i_customer_id integer DEFAULT 0 NOT NULL,
    dt_processed timestamp without time zone
);


ALTER TABLE queueing.tbl_queued_customers OWNER TO bulkmail_user;

--
-- Name: tbl_queued_customers_id_seq; Type: SEQUENCE; Schema: queueing; Owner: bulkmail_user
--

CREATE SEQUENCE queueing.tbl_queued_customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE queueing.tbl_queued_customers_id_seq OWNER TO bulkmail_user;

--
-- Name: tbl_queued_customers_id_seq; Type: SEQUENCE OWNED BY; Schema: queueing; Owner: bulkmail_user
--

ALTER SEQUENCE queueing.tbl_queued_customers_id_seq OWNED BY queueing.tbl_queued_customers.id;


--
-- Name: tbl_users id; Type: DEFAULT; Schema: authentication; Owner: bulkmail_user
--

ALTER TABLE ONLY authentication.tbl_users ALTER COLUMN id SET DEFAULT nextval('authentication.tbl_users_id_seq'::regclass);


--
-- Name: tbl_companies id; Type: DEFAULT; Schema: companies; Owner: bulkmail_user
--

ALTER TABLE ONLY companies.tbl_companies ALTER COLUMN id SET DEFAULT nextval('companies.tbl_companies_id_seq'::regclass);


--
-- Name: tbl_company_email_addresses id; Type: DEFAULT; Schema: companies; Owner: bulkmail_user
--

ALTER TABLE ONLY companies.tbl_company_email_addresses ALTER COLUMN id SET DEFAULT nextval('companies.tbl_company_email_addresses_id_seq'::regclass);


--
-- Name: tbl_company_id_types id; Type: DEFAULT; Schema: companies; Owner: bulkmail_user
--

ALTER TABLE ONLY companies.tbl_company_id_types ALTER COLUMN id SET DEFAULT nextval('companies.tbl_id_types_id_seq'::regclass);


--
-- Name: tbl_countries id; Type: DEFAULT; Schema: companies; Owner: bulkmail_user
--

ALTER TABLE ONLY companies.tbl_countries ALTER COLUMN id SET DEFAULT nextval('companies.tbl_countries_id_seq'::regclass);


--
-- Name: tbl_customer_group_members id; Type: DEFAULT; Schema: customers; Owner: bulkmail_user
--

ALTER TABLE ONLY customers.tbl_customer_group_members ALTER COLUMN id SET DEFAULT nextval('customers.tbl_customer_group_members_id_seq'::regclass);


--
-- Name: tbl_customer_groups id; Type: DEFAULT; Schema: customers; Owner: bulkmail_user
--

ALTER TABLE ONLY customers.tbl_customer_groups ALTER COLUMN id SET DEFAULT nextval('customers.tbl_customer_groups_id_seq'::regclass);


--
-- Name: tbl_customer_id_types id; Type: DEFAULT; Schema: customers; Owner: bulkmail_user
--

ALTER TABLE ONLY customers.tbl_customer_id_types ALTER COLUMN id SET DEFAULT nextval('customers.tbl_id_types_id_seq'::regclass);


--
-- Name: tbl_customers id; Type: DEFAULT; Schema: customers; Owner: bulkmail_user
--

ALTER TABLE ONLY customers.tbl_customers ALTER COLUMN id SET DEFAULT nextval('customers.tbl_customers_id_seq'::regclass);


--
-- Name: tbl_customers_companies id; Type: DEFAULT; Schema: customers; Owner: bulkmail_user
--

ALTER TABLE ONLY customers.tbl_customers_companies ALTER COLUMN id SET DEFAULT nextval('customers.tbl_customers_companies_id_seq'::regclass);


--
-- Name: tbl_attachments id; Type: DEFAULT; Schema: emails; Owner: bulkmail_user
--

ALTER TABLE ONLY emails.tbl_attachments ALTER COLUMN id SET DEFAULT nextval('emails.tbl_attachments_id_seq'::regclass);


--
-- Name: tbl_campaign_customers id; Type: DEFAULT; Schema: emails; Owner: bulkmail_user
--

ALTER TABLE ONLY emails.tbl_campaign_customers ALTER COLUMN id SET DEFAULT nextval('emails.tbl_campaign_customers_id_seq'::regclass);


--
-- Name: tbl_campaign_groups id; Type: DEFAULT; Schema: emails; Owner: bulkmail_user
--

ALTER TABLE ONLY emails.tbl_campaign_groups ALTER COLUMN id SET DEFAULT nextval('emails.tbl_campaign_groups_id_seq'::regclass);


--
-- Name: tbl_campaigns id; Type: DEFAULT; Schema: emails; Owner: bulkmail_user
--

ALTER TABLE ONLY emails.tbl_campaigns ALTER COLUMN id SET DEFAULT nextval('emails.tbl_campaigns_id_seq'::regclass);


--
-- Name: tbl_emails id; Type: DEFAULT; Schema: emails; Owner: bulkmail_user
--

ALTER TABLE ONLY emails.tbl_emails ALTER COLUMN id SET DEFAULT nextval('emails.tbl_emails_id_seq'::regclass);


--
-- Name: tbl_queued_attachments id; Type: DEFAULT; Schema: queueing; Owner: bulkmail_user
--

ALTER TABLE ONLY queueing.tbl_queued_attachments ALTER COLUMN id SET DEFAULT nextval('queueing.tbl_queued_attachments_id_seq'::regclass);


--
-- Name: tbl_queued_click_through_records id; Type: DEFAULT; Schema: queueing; Owner: bulkmail_user
--

ALTER TABLE ONLY queueing.tbl_queued_click_through_records ALTER COLUMN id SET DEFAULT nextval('queueing.tbl_queued_click_through_records_id_seq'::regclass);


--
-- Name: tbl_queued_click_throughs id; Type: DEFAULT; Schema: queueing; Owner: bulkmail_user
--

ALTER TABLE ONLY queueing.tbl_queued_click_throughs ALTER COLUMN id SET DEFAULT nextval('queueing.tbl_queued_click_throughs_id_seq'::regclass);


--
-- Name: tbl_queued_customers id; Type: DEFAULT; Schema: queueing; Owner: bulkmail_user
--

ALTER TABLE ONLY queueing.tbl_queued_customers ALTER COLUMN id SET DEFAULT nextval('queueing.tbl_queued_customers_id_seq'::regclass);


--
-- Name: tbl_queued_emails id; Type: DEFAULT; Schema: queueing; Owner: bulkmail_user
--

ALTER TABLE ONLY queueing.tbl_queued_emails ALTER COLUMN id SET DEFAULT nextval('queueing.tbl_emails_id_seq'::regclass);


--
-- Data for Name: tbl_users; Type: TABLE DATA; Schema: authentication; Owner: bulkmail_user
--

INSERT INTO authentication.tbl_users VALUES (1, 'admin', '$2b$12$pAdJjn/R2Ftuaat3/bUD7O3th9Gr.9JPeHtAW4syTljLlM3GWrRPa', 0, true);
INSERT INTO authentication.tbl_users VALUES (4, 'roger@wilco.com', '$2b$12$Sc5JBIIAZ7Ytnj9pP8vSke/9ukwLWkfEbF/G/Q3IQvPibqZL.3U6q', 4, false);
INSERT INTO authentication.tbl_users VALUES (6, 'roger@spacequest.com', '$2b$12$9jt.ax2ZyrJQzT4NQ4YKTefjiDQ1QWUo3mGiWB7BPu8W0gCCbNw0e', 6, false);
INSERT INTO authentication.tbl_users VALUES (7, 'Nsuku.shiburi@outlook.com', '$2b$12$3vWgvNQg2FlkEEK3H/gmR.J63MNkR0hS79dr1pvA6nx/PLHRpH7cy', 8, false);


--
-- Data for Name: tbl_companies; Type: TABLE DATA; Schema: companies; Owner: bulkmail_user
--

INSERT INTO companies.tbl_companies VALUES (6, 0, '', 'Space Quest', 'Space Quest', NULL, 'Roger Wilco', '', 'roger@wilco.com', '', '0829991234', '', '011-9991234', '', '', '1st', 'Janitor''s Closet', 'Spaceship', 'Galaxy', 'Universe', 'Universe', 200, '9999');
INSERT INTO companies.tbl_companies VALUES (7, 6, '01111', 'Alteram Solutions', '', '2025-09-16', 'Tsakani Chavani', 'Tsakani Chavani', 'tsakani.chavani@alteram.co.za', 'tsakani.chavani@alteram.co.za', '0728165319', '', '0110820013', '', '1144 16th road', '16 th road', 'midrand', 'Midrand', 'Midrand', 'gauteng', 'johannesburg', 200, '1632');
INSERT INTO companies.tbl_companies VALUES (8, 7, '', 'Daily IT Support', 'Daily IT Support', '2025-10-21', 'Nsuku Sagwati Shiburi', 'Nsuku Sagwati Shiburi', 'Nsuku.shiburi@outlook.com', 'Nsuku.shiburi@outlook.com', '0630096733', '0630096733', '0630096733', '', 'Sapitwa Peak', 'block 60', 'Sapitwa Peak', 'Midrand', 'Midrand', 'Gauteng', 'Johannesburg', 19, '1665');


--
-- Data for Name: tbl_company_email_addresses; Type: TABLE DATA; Schema: companies; Owner: bulkmail_user
--

INSERT INTO companies.tbl_company_email_addresses VALUES (2, 6, 'rogerwilco@blindza.xyz', '', 'rogerwilco@blindza.xyz', 'Roger-123', 'dev.blindza.com', 587, true, true);


--
-- Data for Name: tbl_company_id_types; Type: TABLE DATA; Schema: companies; Owner: bulkmail_user
--

INSERT INTO companies.tbl_company_id_types VALUES (1, 'Corporation');
INSERT INTO companies.tbl_company_id_types VALUES (2, 'Closed Corporation');
INSERT INTO companies.tbl_company_id_types VALUES (0, '---not registered---');
INSERT INTO companies.tbl_company_id_types VALUES (1, 'Corporation');
INSERT INTO companies.tbl_company_id_types VALUES (2, 'Closed Corporation');
INSERT INTO companies.tbl_company_id_types VALUES (0, '---not registered---');
INSERT INTO companies.tbl_company_id_types VALUES (1, 'Corporation');
INSERT INTO companies.tbl_company_id_types VALUES (2, 'Closed Corporation');
INSERT INTO companies.tbl_company_id_types VALUES (0, '---not registered---');
INSERT INTO companies.tbl_company_id_types VALUES (6, 'indivudual');
INSERT INTO companies.tbl_company_id_types VALUES (7, 'CIPC');


--
-- Data for Name: tbl_countries; Type: TABLE DATA; Schema: companies; Owner: bulkmail_user
--

INSERT INTO companies.tbl_countries VALUES (1, 'AF', 'Afghanistan', '');
INSERT INTO companies.tbl_countries VALUES (2, 'AL', 'Albania', '');
INSERT INTO companies.tbl_countries VALUES (3, 'DZ', 'Algeria', '');
INSERT INTO companies.tbl_countries VALUES (4, 'AS', 'American Samoa', '');
INSERT INTO companies.tbl_countries VALUES (5, 'AD', 'AndorrA', '');
INSERT INTO companies.tbl_countries VALUES (6, 'AO', 'Angola', '');
INSERT INTO companies.tbl_countries VALUES (7, 'AI', 'Anguilla', '');
INSERT INTO companies.tbl_countries VALUES (8, 'AQ', 'Antarctica', '');
INSERT INTO companies.tbl_countries VALUES (9, 'AG', 'Antigua and Barbuda', '');
INSERT INTO companies.tbl_countries VALUES (10, 'AR', 'Argentina', '');
INSERT INTO companies.tbl_countries VALUES (11, 'AM', 'Armenia', '');
INSERT INTO companies.tbl_countries VALUES (12, 'AW', 'Aruba', '');
INSERT INTO companies.tbl_countries VALUES (13, 'AU', 'Australia', '');
INSERT INTO companies.tbl_countries VALUES (14, 'AT', 'Austria', '');
INSERT INTO companies.tbl_countries VALUES (15, 'AZ', 'Azerbaijan', '');
INSERT INTO companies.tbl_countries VALUES (16, 'BS', 'Bahamas', '');
INSERT INTO companies.tbl_countries VALUES (17, 'BH', 'Bahrain', '');
INSERT INTO companies.tbl_countries VALUES (18, 'BD', 'Bangladesh', '');
INSERT INTO companies.tbl_countries VALUES (19, 'BB', 'Barbados', '');
INSERT INTO companies.tbl_countries VALUES (20, 'BY', 'Belarus', '');
INSERT INTO companies.tbl_countries VALUES (21, 'BE', 'Belgium', '');
INSERT INTO companies.tbl_countries VALUES (22, 'BZ', 'Belize', '');
INSERT INTO companies.tbl_countries VALUES (23, 'BJ', 'Benin', '');
INSERT INTO companies.tbl_countries VALUES (24, 'BM', 'Bermuda', '');
INSERT INTO companies.tbl_countries VALUES (25, 'BT', 'Bhutan', '');
INSERT INTO companies.tbl_countries VALUES (26, 'BO', 'Bolivia', '');
INSERT INTO companies.tbl_countries VALUES (27, 'BA', 'Bosnia and Herzegovina', '');
INSERT INTO companies.tbl_countries VALUES (28, 'BW', 'Botswana', '');
INSERT INTO companies.tbl_countries VALUES (29, 'BV', 'Bouvet Island', '');
INSERT INTO companies.tbl_countries VALUES (30, 'BR', 'Brazil', '');
INSERT INTO companies.tbl_countries VALUES (31, 'IO', 'British Indian Ocean Territory', '');
INSERT INTO companies.tbl_countries VALUES (32, 'BN', 'Brunei Darussalam', '');
INSERT INTO companies.tbl_countries VALUES (33, 'BG', 'Bulgaria', '');
INSERT INTO companies.tbl_countries VALUES (34, 'BF', 'Burkina Faso', '');
INSERT INTO companies.tbl_countries VALUES (35, 'BI', 'Burundi', '');
INSERT INTO companies.tbl_countries VALUES (36, 'KH', 'Cambodia', '');
INSERT INTO companies.tbl_countries VALUES (37, 'CM', 'Cameroon', '');
INSERT INTO companies.tbl_countries VALUES (38, 'CA', 'Canada', '');
INSERT INTO companies.tbl_countries VALUES (39, 'CV', 'Cape Verde', '');
INSERT INTO companies.tbl_countries VALUES (40, 'KY', 'Cayman Islands', '');
INSERT INTO companies.tbl_countries VALUES (41, 'CF', 'Central African Republic', '');
INSERT INTO companies.tbl_countries VALUES (42, 'TD', 'Chad', '');
INSERT INTO companies.tbl_countries VALUES (43, 'CL', 'Chile', '');
INSERT INTO companies.tbl_countries VALUES (44, 'CN', 'China', '');
INSERT INTO companies.tbl_countries VALUES (45, 'CX', 'Christmas Island', '');
INSERT INTO companies.tbl_countries VALUES (46, 'CC', 'Cocos (Keeling) Islands', '');
INSERT INTO companies.tbl_countries VALUES (47, 'CO', 'Colombia', '');
INSERT INTO companies.tbl_countries VALUES (48, 'KM', 'Comoros', '');
INSERT INTO companies.tbl_countries VALUES (49, 'CG', 'Congo', '');
INSERT INTO companies.tbl_countries VALUES (50, 'CD', 'Congo, The Democratic Republic of the', '');
INSERT INTO companies.tbl_countries VALUES (51, 'CK', 'Cook Islands', '');
INSERT INTO companies.tbl_countries VALUES (52, 'CR', 'Costa Rica', '');
INSERT INTO companies.tbl_countries VALUES (53, 'CI', 'Cote D"Ivoire', '');
INSERT INTO companies.tbl_countries VALUES (54, 'HR', 'Croatia', '');
INSERT INTO companies.tbl_countries VALUES (55, 'CU', 'Cuba', '');
INSERT INTO companies.tbl_countries VALUES (56, 'CY', 'Cyprus', '');
INSERT INTO companies.tbl_countries VALUES (57, 'CZ', 'Czech Republic', '');
INSERT INTO companies.tbl_countries VALUES (58, 'DK', 'Denmark', '');
INSERT INTO companies.tbl_countries VALUES (59, 'DJ', 'Djibouti', '');
INSERT INTO companies.tbl_countries VALUES (60, 'DM', 'Dominica', '');
INSERT INTO companies.tbl_countries VALUES (61, 'DO', 'Dominican Republic', '');
INSERT INTO companies.tbl_countries VALUES (62, 'EC', 'Ecuador', '');
INSERT INTO companies.tbl_countries VALUES (63, 'EG', 'Egypt', '');
INSERT INTO companies.tbl_countries VALUES (64, 'SV', 'El Salvador', '');
INSERT INTO companies.tbl_countries VALUES (65, 'GQ', 'Equatorial Guinea', '');
INSERT INTO companies.tbl_countries VALUES (66, 'ER', 'Eritrea', '');
INSERT INTO companies.tbl_countries VALUES (67, 'EE', 'Estonia', '');
INSERT INTO companies.tbl_countries VALUES (68, 'ET', 'Ethiopia', '');
INSERT INTO companies.tbl_countries VALUES (69, 'FK', 'Falkland Islands (Malvinas)', '');
INSERT INTO companies.tbl_countries VALUES (70, 'FO', 'Faroe Islands', '');
INSERT INTO companies.tbl_countries VALUES (71, 'FJ', 'Fiji', '');
INSERT INTO companies.tbl_countries VALUES (72, 'FI', 'Finland', '');
INSERT INTO companies.tbl_countries VALUES (73, 'FR', 'France', '');
INSERT INTO companies.tbl_countries VALUES (74, 'GF', 'French Guiana', '');
INSERT INTO companies.tbl_countries VALUES (75, 'PF', 'French Polynesia', '');
INSERT INTO companies.tbl_countries VALUES (76, 'TF', 'French Southern Territories', '');
INSERT INTO companies.tbl_countries VALUES (77, 'GA', 'Gabon', '');
INSERT INTO companies.tbl_countries VALUES (78, 'GM', 'Gambia', '');
INSERT INTO companies.tbl_countries VALUES (79, 'GE', 'Georgia', '');
INSERT INTO companies.tbl_countries VALUES (80, 'DE', 'Germany', '');
INSERT INTO companies.tbl_countries VALUES (81, 'GH', 'Ghana', '');
INSERT INTO companies.tbl_countries VALUES (82, 'GI', 'Gibraltar', '');
INSERT INTO companies.tbl_countries VALUES (83, 'GR', 'Greece', '');
INSERT INTO companies.tbl_countries VALUES (84, 'GL', 'Greenland', '');
INSERT INTO companies.tbl_countries VALUES (85, 'GD', 'Grenada', '');
INSERT INTO companies.tbl_countries VALUES (86, 'GP', 'Guadeloupe', '');
INSERT INTO companies.tbl_countries VALUES (87, 'GU', 'Guam', '');
INSERT INTO companies.tbl_countries VALUES (88, 'GT', 'Guatemala', '');
INSERT INTO companies.tbl_countries VALUES (89, 'GG', 'Guernsey', '');
INSERT INTO companies.tbl_countries VALUES (90, 'GN', 'Guinea', '');
INSERT INTO companies.tbl_countries VALUES (91, 'GW', 'Guinea-Bissau', '');
INSERT INTO companies.tbl_countries VALUES (92, 'GY', 'Guyana', '');
INSERT INTO companies.tbl_countries VALUES (93, 'HT', 'Haiti', '');
INSERT INTO companies.tbl_countries VALUES (94, 'HM', 'Heard Island and Mcdonald Islands', '');
INSERT INTO companies.tbl_countries VALUES (95, 'VA', 'Holy See (Vatican City State)', '');
INSERT INTO companies.tbl_countries VALUES (96, 'HN', 'Honduras', '');
INSERT INTO companies.tbl_countries VALUES (97, 'HK', 'Hong Kong', '');
INSERT INTO companies.tbl_countries VALUES (98, 'HU', 'Hungary', '');
INSERT INTO companies.tbl_countries VALUES (99, 'IS', 'Iceland', '');
INSERT INTO companies.tbl_countries VALUES (100, 'IN', 'India', '');
INSERT INTO companies.tbl_countries VALUES (101, 'ID', 'Indonesia', '');
INSERT INTO companies.tbl_countries VALUES (102, 'IR', 'Iran, Islamic Republic Of', '');
INSERT INTO companies.tbl_countries VALUES (103, 'IQ', 'Iraq', '');
INSERT INTO companies.tbl_countries VALUES (104, 'IE', 'Ireland', '');
INSERT INTO companies.tbl_countries VALUES (105, 'IM', 'Isle of Man', '');
INSERT INTO companies.tbl_countries VALUES (106, 'IL', 'Israel', '');
INSERT INTO companies.tbl_countries VALUES (107, 'IT', 'Italy', '');
INSERT INTO companies.tbl_countries VALUES (108, 'JM', 'Jamaica', '');
INSERT INTO companies.tbl_countries VALUES (109, 'JP', 'Japan', '');
INSERT INTO companies.tbl_countries VALUES (110, 'JE', 'Jersey', '');
INSERT INTO companies.tbl_countries VALUES (111, 'JO', 'Jordan', '');
INSERT INTO companies.tbl_countries VALUES (112, 'KZ', 'Kazakhstan', '');
INSERT INTO companies.tbl_countries VALUES (113, 'KE', 'Kenya', '');
INSERT INTO companies.tbl_countries VALUES (114, 'KI', 'Kiribati', '');
INSERT INTO companies.tbl_countries VALUES (115, 'KP', 'Korea, Democratic People"S Republic of', '');
INSERT INTO companies.tbl_countries VALUES (116, 'KR', 'Korea, Republic of', '');
INSERT INTO companies.tbl_countries VALUES (117, 'KW', 'Kuwait', '');
INSERT INTO companies.tbl_countries VALUES (118, 'KG', 'Kyrgyzstan', '');
INSERT INTO companies.tbl_countries VALUES (119, 'LA', 'Lao People"S Democratic Republic', '');
INSERT INTO companies.tbl_countries VALUES (120, 'LV', 'Latvia', '');
INSERT INTO companies.tbl_countries VALUES (121, 'LB', 'Lebanon', '');
INSERT INTO companies.tbl_countries VALUES (122, 'LS', 'Lesotho', '');
INSERT INTO companies.tbl_countries VALUES (123, 'LR', 'Liberia', '');
INSERT INTO companies.tbl_countries VALUES (124, 'LY', 'Libyan Arab Jamahiriya', '');
INSERT INTO companies.tbl_countries VALUES (125, 'LI', 'Liechtenstein', '');
INSERT INTO companies.tbl_countries VALUES (126, 'LT', 'Lithuania', '');
INSERT INTO companies.tbl_countries VALUES (127, 'LU', 'Luxembourg', '');
INSERT INTO companies.tbl_countries VALUES (128, 'MO', 'Macao', '');
INSERT INTO companies.tbl_countries VALUES (129, 'MK', 'Macedonia, The Former Yugoslav Republic of', '');
INSERT INTO companies.tbl_countries VALUES (130, 'MG', 'Madagascar', '');
INSERT INTO companies.tbl_countries VALUES (131, 'MW', 'Malawi', '');
INSERT INTO companies.tbl_countries VALUES (132, 'MY', 'Malaysia', '');
INSERT INTO companies.tbl_countries VALUES (133, 'MV', 'Maldives', '');
INSERT INTO companies.tbl_countries VALUES (134, 'ML', 'Mali', '');
INSERT INTO companies.tbl_countries VALUES (135, 'MT', 'Malta', '');
INSERT INTO companies.tbl_countries VALUES (136, 'MH', 'Marshall Islands', '');
INSERT INTO companies.tbl_countries VALUES (137, 'MQ', 'Martinique', '');
INSERT INTO companies.tbl_countries VALUES (138, 'MR', 'Mauritania', '');
INSERT INTO companies.tbl_countries VALUES (139, 'MU', 'Mauritius', '');
INSERT INTO companies.tbl_countries VALUES (140, 'YT', 'Mayotte', '');
INSERT INTO companies.tbl_countries VALUES (141, 'MX', 'Mexico', '');
INSERT INTO companies.tbl_countries VALUES (142, 'FM', 'Micronesia, Federated States of', '');
INSERT INTO companies.tbl_countries VALUES (143, 'MD', 'Moldova, Republic of', '');
INSERT INTO companies.tbl_countries VALUES (144, 'MC', 'Monaco', '');
INSERT INTO companies.tbl_countries VALUES (145, 'MN', 'Mongolia', '');
INSERT INTO companies.tbl_countries VALUES (146, 'MS', 'Montserrat', '');
INSERT INTO companies.tbl_countries VALUES (147, 'MA', 'Morocco', '');
INSERT INTO companies.tbl_countries VALUES (148, 'MZ', 'Mozambique', '');
INSERT INTO companies.tbl_countries VALUES (149, 'MM', 'Myanmar', '');
INSERT INTO companies.tbl_countries VALUES (150, 'NA', 'Namibia', '');
INSERT INTO companies.tbl_countries VALUES (151, 'NR', 'Nauru', '');
INSERT INTO companies.tbl_countries VALUES (152, 'NP', 'Nepal', '');
INSERT INTO companies.tbl_countries VALUES (153, 'NL', 'Netherlands', '');
INSERT INTO companies.tbl_countries VALUES (154, 'AN', 'Netherlands Antilles', '');
INSERT INTO companies.tbl_countries VALUES (155, 'NC', 'New Caledonia', '');
INSERT INTO companies.tbl_countries VALUES (156, 'NZ', 'New Zealand', '');
INSERT INTO companies.tbl_countries VALUES (157, 'NI', 'Nicaragua', '');
INSERT INTO companies.tbl_countries VALUES (158, 'NE', 'Niger', '');
INSERT INTO companies.tbl_countries VALUES (159, 'NG', 'Nigeria', '');
INSERT INTO companies.tbl_countries VALUES (160, 'NU', 'Niue', '');
INSERT INTO companies.tbl_countries VALUES (161, 'NF', 'Norfolk Island', '');
INSERT INTO companies.tbl_countries VALUES (162, 'MP', 'Northern Mariana Islands', '');
INSERT INTO companies.tbl_countries VALUES (163, 'NO', 'Norway', '');
INSERT INTO companies.tbl_countries VALUES (164, 'OM', 'Oman', '');
INSERT INTO companies.tbl_countries VALUES (165, 'PK', 'Pakistan', '');
INSERT INTO companies.tbl_countries VALUES (166, 'PW', 'Palau', '');
INSERT INTO companies.tbl_countries VALUES (167, 'PS', 'Palestinian Territory, Occupied', '');
INSERT INTO companies.tbl_countries VALUES (168, 'PA', 'Panama', '');
INSERT INTO companies.tbl_countries VALUES (169, 'PG', 'Papua New Guinea', '');
INSERT INTO companies.tbl_countries VALUES (170, 'PY', 'Paraguay', '');
INSERT INTO companies.tbl_countries VALUES (171, 'PE', 'Peru', '');
INSERT INTO companies.tbl_countries VALUES (172, 'PH', 'Philippines', '');
INSERT INTO companies.tbl_countries VALUES (173, 'PN', 'Pitcairn', '');
INSERT INTO companies.tbl_countries VALUES (174, 'PL', 'Poland', '');
INSERT INTO companies.tbl_countries VALUES (175, 'PT', 'Portugal', '');
INSERT INTO companies.tbl_countries VALUES (176, 'PR', 'Puerto Rico', '');
INSERT INTO companies.tbl_countries VALUES (177, 'QA', 'Qatar', '');
INSERT INTO companies.tbl_countries VALUES (178, 'RE', 'Reunion', '');
INSERT INTO companies.tbl_countries VALUES (179, 'RO', 'Romania', '');
INSERT INTO companies.tbl_countries VALUES (180, 'RU', 'Russian Federation', '');
INSERT INTO companies.tbl_countries VALUES (181, 'RW', 'RWANDA', '');
INSERT INTO companies.tbl_countries VALUES (182, 'SH', 'Saint Helena', '');
INSERT INTO companies.tbl_countries VALUES (183, 'KN', 'Saint Kitts and Nevis', '');
INSERT INTO companies.tbl_countries VALUES (184, 'LC', 'Saint Lucia', '');
INSERT INTO companies.tbl_countries VALUES (185, 'PM', 'Saint Pierre and Miquelon', '');
INSERT INTO companies.tbl_countries VALUES (186, 'VC', 'Saint Vincent and the Grenadines', '');
INSERT INTO companies.tbl_countries VALUES (187, 'WS', 'Samoa', '');
INSERT INTO companies.tbl_countries VALUES (188, 'SM', 'San Marino', '');
INSERT INTO companies.tbl_countries VALUES (189, 'ST', 'Sao Tome and Principe', '');
INSERT INTO companies.tbl_countries VALUES (190, 'SA', 'Saudi Arabia', '');
INSERT INTO companies.tbl_countries VALUES (191, 'SN', 'Senegal', '');
INSERT INTO companies.tbl_countries VALUES (192, 'CS', 'Serbia and Montenegro', '');
INSERT INTO companies.tbl_countries VALUES (193, 'SC', 'Seychelles', '');
INSERT INTO companies.tbl_countries VALUES (194, 'SL', 'Sierra Leone', '');
INSERT INTO companies.tbl_countries VALUES (195, 'SG', 'Singapore', '');
INSERT INTO companies.tbl_countries VALUES (196, 'SK', 'Slovakia', '');
INSERT INTO companies.tbl_countries VALUES (197, 'SI', 'Slovenia', '');
INSERT INTO companies.tbl_countries VALUES (198, 'SB', 'Solomon Islands', '');
INSERT INTO companies.tbl_countries VALUES (199, 'SO', 'Somalia', '');
INSERT INTO companies.tbl_countries VALUES (200, 'ZA', 'South Africa', '');
INSERT INTO companies.tbl_countries VALUES (201, 'GS', 'South Georgia and the South Sandwich Islands', '');
INSERT INTO companies.tbl_countries VALUES (202, 'ES', 'Spain', '');
INSERT INTO companies.tbl_countries VALUES (203, 'LK', 'Sri Lanka', '');
INSERT INTO companies.tbl_countries VALUES (204, 'SD', 'Sudan', '');
INSERT INTO companies.tbl_countries VALUES (205, 'SR', 'Suriname', '');
INSERT INTO companies.tbl_countries VALUES (206, 'SJ', 'Svalbard and Jan Mayen', '');
INSERT INTO companies.tbl_countries VALUES (207, 'SZ', 'Swaziland', '');
INSERT INTO companies.tbl_countries VALUES (208, 'SE', 'Sweden', '');
INSERT INTO companies.tbl_countries VALUES (209, 'CH', 'Switzerland', '');
INSERT INTO companies.tbl_countries VALUES (210, 'SY', 'Syrian Arab Republic', '');
INSERT INTO companies.tbl_countries VALUES (211, 'TW', 'Taiwan, Province of China', '');
INSERT INTO companies.tbl_countries VALUES (212, 'TJ', 'Tajikistan', '');
INSERT INTO companies.tbl_countries VALUES (213, 'TZ', 'Tanzania, United Republic of', '');
INSERT INTO companies.tbl_countries VALUES (214, 'TH', 'Thailand', '');
INSERT INTO companies.tbl_countries VALUES (215, 'TL', 'Timor-Leste', '');
INSERT INTO companies.tbl_countries VALUES (216, 'TG', 'Togo', '');
INSERT INTO companies.tbl_countries VALUES (217, 'TK', 'Tokelau', '');
INSERT INTO companies.tbl_countries VALUES (218, 'TO', 'Tonga', '');
INSERT INTO companies.tbl_countries VALUES (219, 'TT', 'Trinidad and Tobago', '');
INSERT INTO companies.tbl_countries VALUES (220, 'TN', 'Tunisia', '');
INSERT INTO companies.tbl_countries VALUES (221, 'TR', 'Turkey', '');
INSERT INTO companies.tbl_countries VALUES (222, 'TM', 'Turkmenistan', '');
INSERT INTO companies.tbl_countries VALUES (223, 'TC', 'Turks and Caicos Islands', '');
INSERT INTO companies.tbl_countries VALUES (224, 'TV', 'Tuvalu', '');
INSERT INTO companies.tbl_countries VALUES (225, 'UG', 'Uganda', '');
INSERT INTO companies.tbl_countries VALUES (226, 'UA', 'Ukraine', '');
INSERT INTO companies.tbl_countries VALUES (227, 'AE', 'United Arab Emirates', '');
INSERT INTO companies.tbl_countries VALUES (228, 'GB', 'United Kingdom', '');
INSERT INTO companies.tbl_countries VALUES (229, 'US', 'United States', '');
INSERT INTO companies.tbl_countries VALUES (230, 'UM', 'United States Minor Outlying Islands', '');
INSERT INTO companies.tbl_countries VALUES (231, 'UY', 'Uruguay', '');
INSERT INTO companies.tbl_countries VALUES (232, 'UZ', 'Uzbekistan', '');
INSERT INTO companies.tbl_countries VALUES (233, 'VU', 'Vanuatu', '');
INSERT INTO companies.tbl_countries VALUES (234, 'VE', 'Venezuela', '');
INSERT INTO companies.tbl_countries VALUES (235, 'VN', 'Viet Nam', '');
INSERT INTO companies.tbl_countries VALUES (236, 'VG', 'Virgin Islands, British', '');
INSERT INTO companies.tbl_countries VALUES (237, 'VI', 'Virgin Islands, U.S.', '');
INSERT INTO companies.tbl_countries VALUES (238, 'WF', 'Wallis and Futuna', '');
INSERT INTO companies.tbl_countries VALUES (239, 'EH', 'Western Sahara', '');
INSERT INTO companies.tbl_countries VALUES (240, 'YE', 'Yemen', '');
INSERT INTO companies.tbl_countries VALUES (241, 'ZM', 'Zambia', '');
INSERT INTO companies.tbl_countries VALUES (242, 'ZW', 'Zimbabwe', '');


--
-- Data for Name: tbl_id_types; Type: TABLE DATA; Schema: companies; Owner: bulkmail_user
--



--
-- Data for Name: tbl_customer_group_members; Type: TABLE DATA; Schema: customers; Owner: bulkmail_user
--

INSERT INTO customers.tbl_customer_group_members VALUES (11, 19, 2);
INSERT INTO customers.tbl_customer_group_members VALUES (14, 24, 2);
INSERT INTO customers.tbl_customer_group_members VALUES (17, 27, 2);
INSERT INTO customers.tbl_customer_group_members VALUES (18, 28, 2);
INSERT INTO customers.tbl_customer_group_members VALUES (19, 29, 2);
INSERT INTO customers.tbl_customer_group_members VALUES (20, 30, 2);
INSERT INTO customers.tbl_customer_group_members VALUES (24, 34, 2);
INSERT INTO customers.tbl_customer_group_members VALUES (25, 35, 2);
INSERT INTO customers.tbl_customer_group_members VALUES (26, 36, 2);
INSERT INTO customers.tbl_customer_group_members VALUES (31, 31, 2);
INSERT INTO customers.tbl_customer_group_members VALUES (32, 25, 2);
INSERT INTO customers.tbl_customer_group_members VALUES (33, 33, 2);
INSERT INTO customers.tbl_customer_group_members VALUES (34, 20, 2);
INSERT INTO customers.tbl_customer_group_members VALUES (35, 37, 2);
INSERT INTO customers.tbl_customer_group_members VALUES (36, 38, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (37, 39, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (38, 40, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (39, 41, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (40, 42, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (41, 43, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (42, 44, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (43, 45, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (44, 46, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (45, 47, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (46, 48, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (47, 49, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (48, 50, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (49, 51, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (50, 52, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (51, 53, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (52, 54, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (53, 55, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (54, 56, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (55, 57, 5);
INSERT INTO customers.tbl_customer_group_members VALUES (56, 59, 2);
INSERT INTO customers.tbl_customer_group_members VALUES (57, 60, 6);


--
-- Data for Name: tbl_customer_groups; Type: TABLE DATA; Schema: customers; Owner: bulkmail_user
--

INSERT INTO customers.tbl_customer_groups VALUES (2, 6, 'test_group', 'just for testing...');
INSERT INTO customers.tbl_customer_groups VALUES (5, 6, 'literary_media', 'test values');
INSERT INTO customers.tbl_customer_groups VALUES (6, 6, 'APs', 'Solutions');


--
-- Data for Name: tbl_customer_id_types; Type: TABLE DATA; Schema: customers; Owner: bulkmail_user
--

INSERT INTO customers.tbl_customer_id_types VALUES (1, 'South African I.D.');
INSERT INTO customers.tbl_customer_id_types VALUES (3, 'Passport');
INSERT INTO customers.tbl_customer_id_types VALUES (1, 'South African I.D.');
INSERT INTO customers.tbl_customer_id_types VALUES (3, 'Passport');
INSERT INTO customers.tbl_customer_id_types VALUES (1, 'South African I.D.');
INSERT INTO customers.tbl_customer_id_types VALUES (3, 'Passport');
INSERT INTO customers.tbl_customer_id_types VALUES (7, 'ID');
INSERT INTO customers.tbl_customer_id_types VALUES (8, 'id');


--
-- Data for Name: tbl_customers; Type: TABLE DATA; Schema: customers; Owner: bulkmail_user
--

INSERT INTO customers.tbl_customers VALUES (36, 1, '7201015566998', 'Mr', 'knersis', 'Pterodactyl', '', 'South Africa', '0825551234', '', '0119988765', '', 'knersis@Pterodactyl.com', '', '1', 'Smith', 'Sandton', 'Johannesburg', 'Gauteng', '', 'same
', false);
INSERT INTO customers.tbl_customers VALUES (48, 1, '1122334455667788', 'Mr', 'stephen', 'king', 'm', 'South African', '0821112233', '', '0119992233', '', 'stephen.king@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (49, 1, '1122334455667788', 'Mr', 'arthur.c', 'clarke', 'm', 'South African', '0821112233', '', '0119992233', '', 'arthur.c.clarke@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (50, 1, '1122334455667788', 'Mr', 'isaac', 'asimov', 'm', 'South African', '0821112233', '', '0119992233', '', 'isaac.asimov@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (51, 1, '1122334455667788', 'Mr', 'wilbur', 'smith', 'm', 'South African', '0821112233', '', '0119992233', '', 'wilbur.smith@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (52, 1, '1122334455667788', 'Mr', 'george', 'lucas', 'm', 'South African', '0821112233', '', '0119992233', '', 'george.lucas@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (53, 1, '1122334455667788', 'Mr', 'alan.dean', 'foster', 'm', 'South African', '0821112233', '', '0119992233', '', 'alan.dean.foster@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (54, 1, '1122334455667788', 'Mr', 'andre', 'norton', 'm', 'South African', '0821112233', '', '0119992233', '', 'andre.norton@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (22, 1, '7777777777777', 'Mr', 'Nobody', 'Noone', 'M', 'South Africa', '0821112233', '', '0119992233', '', 'nobody@nowhere.com', '', '', 'Not', 'Nowhere', 'Nowhere', 'Gauteng', '1111', '', false);
INSERT INTO customers.tbl_customers VALUES (20, 1, '7705244007088', 'Ms', 'Jane Julia', 'Doe', 'F', 'South Africa', '0761112233', '', '0123334455', '', 'jane@doe.com', '', '1 Place Name - 55', ' Smith', ' Muckleneuck', 'Pretoria', 'Gauteng', '', 'same', false);
INSERT INTO customers.tbl_customers VALUES (19, 1, '7201015566998', 'Mr', 'John', 'Smith', '', 'South Africa', '0825551234', '', '0119988765', '', 'john@smith.com', '', '1', 'Smith', 'Sandton', 'Johannesburg', 'Gauteng', '', 'same
', false);
INSERT INTO customers.tbl_customers VALUES (55, 1, '1122334455667788', 'Mr', 'charles', 'dickens', 'm', 'South African', '0821112233', '', '0119992233', '', 'charles.dickens@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (56, 1, '1122334455667788', 'Mr', 'j.k', 'rowling', 'm', 'South African', '0821112233', '', '0119992233', '', 'j.k.rowling@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (57, 1, '1122334455667788', 'Mr', 'sun', 'tzu', 'm', 'South African', '0821112233', '', '0119992233', '', 'sun.tzu@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (40, 1, '1122334455667788', 'Mr', 'john', 'lennon', '', '---', '0821112233', '', '0119992233', '', 'john.lennon@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', '', 'postal_address
', false);
INSERT INTO customers.tbl_customers VALUES (24, 1, '7201015566998', 'Mr', 'paul', 'McCartney', '', 'South Africa', '0825551234', '', '0119988765', '', 'paul@McCartney.com', '', '1', 'Smith', 'Sandton', 'Johannesburg', 'Gauteng', '', 'same
', false);
INSERT INTO customers.tbl_customers VALUES (25, 1, '7201015566998', 'Mr', 'george', 'Harrison', '', 'South Africa', '0825551234', '', '0119988765', '', 'george@Harrison.com', '', '1', 'Smith', 'Sandton', 'Johannesburg', 'Gauteng', '', 'same
', false);
INSERT INTO customers.tbl_customers VALUES (26, 1, '7201015566998', 'Mr', 'ringo', 'Starr', '', 'South Africa', '0825551234', '', '0119988765', '', 'ringo@Starr.com', '', '1', 'Smith', 'Sandton', 'Johannesburg', 'Gauteng', '', 'same
', false);
INSERT INTO customers.tbl_customers VALUES (27, 1, '7201015566998', 'Mr', 'dennis', 'Menace', '', 'South Africa', '0825551234', '', '0119988765', '', 'dennis@Menace.com', '', '1', 'Smith', 'Sandton', 'Johannesburg', 'Gauteng', '', 'same
', false);
INSERT INTO customers.tbl_customers VALUES (28, 1, '7201015566998', 'Mr', 'popeye', 'Sailorman', '', 'South Africa', '0825551234', '', '0119988765', '', 'popeye@Sailorman.com', '', '1', 'Smith', 'Sandton', 'Johannesburg', 'Gauteng', '', 'same
', false);
INSERT INTO customers.tbl_customers VALUES (29, 1, '7201015566998', 'Mr', 'olive', 'Oyl', '', 'South Africa', '0825551234', '', '0119988765', '', 'olive@Oyl.com', '', '1', 'Smith', 'Sandton', 'Johannesburg', 'Gauteng', '', 'same
', false);
INSERT INTO customers.tbl_customers VALUES (30, 1, '7201015566998', 'Mr', 'tintin', 'Reporter', '', 'South Africa', '0825551234', '', '0119988765', '', 'tintin@Reporter.com', '', '1', 'Smith', 'Sandton', 'Johannesburg', 'Gauteng', '', 'same
', false);
INSERT INTO customers.tbl_customers VALUES (31, 1, '7201015566998', 'Mr', 'snowy', 'Dog', '', 'South Africa', '0825551234', '', '0119988765', '', 'snowy@Dog.com', '', '1', 'Smith', 'Sandton', 'Johannesburg', 'Gauteng', '', 'same
', false);
INSERT INTO customers.tbl_customers VALUES (33, 1, '7201015566998', 'Mr', 'garfield', 'Cat', '', 'South Africa', '0825551234', '', '0119988765', '', 'garfield@Cat.com', '', '1', 'Smith', 'Sandton', 'Johannesburg', 'Gauteng', '', 'same
', false);
INSERT INTO customers.tbl_customers VALUES (34, 1, '7201015566998', 'Mr', 'morph', 'Plasticine', '', 'South Africa', '0825551234', '', '0119988765', '', 'morph@Plasticine.com', '', '1', 'Smith', 'Sandton', 'Johannesburg', 'Gauteng', '', 'same
', false);
INSERT INTO customers.tbl_customers VALUES (35, 1, '7201015566998', 'Mr', 'oskar', 'Hasie', '', 'South Africa', '0825551234', '', '0119988765', '', 'oskar@Hasie.com', '', '1', 'Smith', 'Sandton', 'Johannesburg', 'Gauteng', '', 'same
', false);
INSERT INTO customers.tbl_customers VALUES (32, 1, '7201015566998', 'Mr', 'Captain', 'Haddock', '', 'South Africa', '0825551234', '', '0119988765', '', 'haddock@Captain.com', '', '1', 'Smith', 'Sandton', 'Johannesburg', 'Gauteng', '', 'same
', false);
INSERT INTO customers.tbl_customers VALUES (37, 1, '99999999', 'Mr.', 'Odi (Not!)', 'Cattoo', 'M', 'South Africa', '0821112223333', '', '0119991122', '', 'garfield@Cat.com', '', '', '', 'Johannesburg', 'Johannesburg', 'Gauteng', '2000', '', false);
INSERT INTO customers.tbl_customers VALUES (38, 1, '1122334455667788', 'Mr', 'garfield', 'cat', 'm', 'South African', '0821112233', '', '0119992233', '', 'garfield.cat@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (39, 1, '1122334455667788', 'Mr', 'odie', 'dog', 'm', 'South African', '0821112233', '', '0119992233', '', 'odie.dog@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (41, 1, '1122334455667788', 'Mr', 'paul', 'mccartney', 'm', 'South African', '0821112233', '', '0119992233', '', 'paul.mccartney@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (42, 1, '1122334455667788', 'Mr', 'ringo', 'starr', 'm', 'South African', '0821112233', '', '0119992233', '', 'ringo.starr@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (43, 1, '1122334455667788', 'Mr', 'george', 'harrison', 'm', 'South African', '0821112233', '', '0119992233', '', 'george.harrison@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (44, 1, '1122334455667788', 'Mr', 'tintin', 'journalist', 'm', 'South African', '0821112233', '', '0119992233', '', 'tintin@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (45, 1, '1122334455667788', 'Mr', 'snowy', 'dog', 'm', 'South African', '0821112233', '', '0119992233', '', 'snowy.dog@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (46, 1, '1122334455667788', 'Mr', 'captain', 'haddock', 'm', 'South African', '0821112233', '', '0119992233', '', 'captain.haddock@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (47, 1, '1122334455667788', 'Mr', 'michael', 'ende', 'm', 'South African', '0821112233', '', '0119992233', '', 'michael.ende@blindza.xyz', '', 'address', 'street_name', 'suburb', 'city', 'province', 'postal_code', 'postal_address', false);
INSERT INTO customers.tbl_customers VALUES (58, 1, '0000000000', 'Miss', 'Tsakani', 'Chavani', 'F', 'South Africa', '0728165319', '0728165319', '0110820013', '0110820013', 'tsakani.chavani@alteram.co.za', 'tsakani.chavani@alteram.co.za', '1144 16th road', 'Alteram', 'Midrand', 'Midrand', 'gauteng', '1632', '1144 16th road
Alteram', false);
INSERT INTO customers.tbl_customers VALUES (59, 0, '0000000000', 'Miss', 'Tsakani', 'Chavani', 'M', '---', '0728165319', '', '0110820013', '0110820013', 'tsakani.chavani@alteram.co.za', 'tsakani.chavani@alteram.co.za', '1144 16th road', 'Alteram', 'Midrand', 'Midrand', 'gauteng', '1632', '', false);
INSERT INTO customers.tbl_customers VALUES (60, 0, 'miss', 'Miss', 'Tsakani', 'Chavani', 'M', 'American Samoa', '0728165319', '0728165319', '0110820013', '0110820013', 'tsakani.chavani@alteram.co.za', 'tsakani.chavani@alteram.co.za', '1144 16th road', 'Alteram', 'Midrand', 'Midrand', 'gauteng', '1632', '1144 16th road
Alteram', false);
INSERT INTO customers.tbl_customers VALUES (62, 7, '0005235513081', 'Mr', 'Nsuku', 'Shiburi', 'M', 'South Africa', '0630096733', '', '', '', 'Nsuku.shiburi@outlook.com', '', '9119 Sapitwa Peak Street, Clayville', 'Sapitwa Peak Street', 'Midrand', 'Midrand', 'Gauteng', '', '', false);


--
-- Data for Name: tbl_customers_companies; Type: TABLE DATA; Schema: customers; Owner: bulkmail_user
--

INSERT INTO customers.tbl_customers_companies VALUES (9, 19, 6);
INSERT INTO customers.tbl_customers_companies VALUES (10, 20, 6);
INSERT INTO customers.tbl_customers_companies VALUES (11, 22, 6);
INSERT INTO customers.tbl_customers_companies VALUES (13, 24, 6);
INSERT INTO customers.tbl_customers_companies VALUES (14, 25, 6);
INSERT INTO customers.tbl_customers_companies VALUES (15, 26, 6);
INSERT INTO customers.tbl_customers_companies VALUES (16, 27, 6);
INSERT INTO customers.tbl_customers_companies VALUES (17, 28, 6);
INSERT INTO customers.tbl_customers_companies VALUES (18, 29, 6);
INSERT INTO customers.tbl_customers_companies VALUES (19, 30, 6);
INSERT INTO customers.tbl_customers_companies VALUES (20, 31, 6);
INSERT INTO customers.tbl_customers_companies VALUES (21, 32, 6);
INSERT INTO customers.tbl_customers_companies VALUES (22, 33, 6);
INSERT INTO customers.tbl_customers_companies VALUES (23, 34, 6);
INSERT INTO customers.tbl_customers_companies VALUES (24, 35, 6);
INSERT INTO customers.tbl_customers_companies VALUES (25, 36, 6);
INSERT INTO customers.tbl_customers_companies VALUES (26, 37, 6);
INSERT INTO customers.tbl_customers_companies VALUES (27, 38, 6);
INSERT INTO customers.tbl_customers_companies VALUES (28, 39, 6);
INSERT INTO customers.tbl_customers_companies VALUES (29, 40, 6);
INSERT INTO customers.tbl_customers_companies VALUES (30, 41, 6);
INSERT INTO customers.tbl_customers_companies VALUES (31, 42, 6);
INSERT INTO customers.tbl_customers_companies VALUES (32, 43, 6);
INSERT INTO customers.tbl_customers_companies VALUES (33, 44, 6);
INSERT INTO customers.tbl_customers_companies VALUES (34, 45, 6);
INSERT INTO customers.tbl_customers_companies VALUES (35, 46, 6);
INSERT INTO customers.tbl_customers_companies VALUES (36, 47, 6);
INSERT INTO customers.tbl_customers_companies VALUES (37, 48, 6);
INSERT INTO customers.tbl_customers_companies VALUES (38, 49, 6);
INSERT INTO customers.tbl_customers_companies VALUES (39, 50, 6);
INSERT INTO customers.tbl_customers_companies VALUES (40, 51, 6);
INSERT INTO customers.tbl_customers_companies VALUES (41, 52, 6);
INSERT INTO customers.tbl_customers_companies VALUES (42, 53, 6);
INSERT INTO customers.tbl_customers_companies VALUES (43, 54, 6);
INSERT INTO customers.tbl_customers_companies VALUES (44, 55, 6);
INSERT INTO customers.tbl_customers_companies VALUES (45, 56, 6);
INSERT INTO customers.tbl_customers_companies VALUES (46, 57, 6);
INSERT INTO customers.tbl_customers_companies VALUES (47, 58, 6);
INSERT INTO customers.tbl_customers_companies VALUES (48, 59, 6);
INSERT INTO customers.tbl_customers_companies VALUES (49, 60, 6);
INSERT INTO customers.tbl_customers_companies VALUES (51, 62, 6);


--
-- Data for Name: tbl_id_types; Type: TABLE DATA; Schema: customers; Owner: bulkmail_user
--



--
-- Data for Name: tbl_attachments; Type: TABLE DATA; Schema: emails; Owner: bulkmail_user
--

INSERT INTO emails.tbl_attachments VALUES (2, 'black.jpg', 'image/jpeg', '\xffd8ffe000104a46494600010101006000600000ffe100224578696600004d4d002a00000008000101120003000000010001000000000000ffdb0043000201010201010202020202020202030503030303030604040305070607070706070708090b0908080a0807070a0d0a0a0b0c0c0c0c07090e0f0d0c0e0b0c0c0cffdb004301020202030303060303060c0807080c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0cffc00011080032003203012200021101031101ffc4001f0000010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffc4001f0100030101010101010101010000000000000102030405060708090a0bffc400b51100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00fe7fe8a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a00ffd9', 4);
INSERT INTO emails.tbl_attachments VALUES (3, 'chart.png', 'image/png', '\x89504e470d0a1a0a0000000d49484452000003890000021e0806000000163a4a1a000000017352474200aece1ce90000200049444154785eec9d0b9c5555bdf87f730e03230316231a208c5486022a0431297a2b07e58e5d4d13f2d58dd0ca7c70351ff8c25e37cdf75b44b312e9decc02adb47b2754c492b10051ff755141530615aec9f8e031e37066e6ff59bbbb8f670e67ce633fd75afb7b3e9f3ec999bdd6faadefefb7e79cefacbdd7ae1ab1777d8ff082000420000108400002108000042000010888481592481d40000210800004200001084000021080804b0049a41620000108400002108000042000010840204b0049a418200001084000021080000420000108400049a40620000108400002108000042000010840605702ac24521510800004200001084000021080000420c04a22350001084000021080000420000108400002ac24520310800004200001084000021080000420508400979b521e1080000420000108400002108000042090258024520c10800004200001084000021080000420802452031080809904264dfaa47cfd6ba7c9d4a95365c8900f4bbf7efd9c89747474c8ebafbf214b1e78407ef2939fcab66ddbcd9c60c851dfff8b9fcb61871dea8ca218cd9b77b92c5ef240c8a37aef7ee68ce3e5ca2baf9041836afbec2493c9c87befbd27cf3cf3ac2cb8f32e79eaa93f791f30af65fef84f3eb9424e3ce914e7a8623f0b2c00cd3b9a7be10572f6d9674a757575af487ffbdb87e4ccb3e6ec12fda1874e955b6fb949860d1bd6eb67ebd6ad97c31b8f0864b6c3870f976f5f7e99d4d4d4c8695ffb46c57d92d78a91d1000210b090002b891626952941c05602dffbde77e4a4134f90c18307f739c59e9e1ef9dbdf5e91ef7deffbb2ecf1e5b6a2f03c2f1b2531178612dfbb7ef423b9f1c69b3d33ca6d882416c7d89724befaeaabf29559a7cadffef6b75e1d9c75d61972c1f9e7390297fb0a4212d51f12bef6b5d3e4b4534f95a143f7905ca1afa41890c44a68712c0420602b0124d1d6cc322f085846e0e69b6e902f7ef1b8ecca61a9e9bdf1c61bf2adf32e90152b5a4a1dcacf352650ce4a627ef86a55f187575d233ffbd97ff89e19c2e04d12b76edd26dff9eef7e497bffc55af0e16dc71bb7ce10bc7ecd269109248ae7c973b1d40000210c812401229060840407b0273ce3e4bce3befdcecea835a2d549716fef4a7f7c883bffe8d4c9c3041ce38e374993efd4819306080331f75cca38f3e26b34ffd9af6f323c0be0994fae2af727fecb1c7c8f1c71fefac1eb9af575e79c5b9d450c9879f57a9f1fdf46d43dbbe5612bbbbbb65d1a2ff9079977f3b3b4db5d2f7dbdffe5af61b330649b421f9cc010210b09a009268757a991c04cc27a0be582e59fc2b39e080f1ce64bababae4c1077f2de77eebfc5d2677f1c573e59ba77f232b8a7ffffb5b72fef917f4baecf4e4934f74ee691c3d7a74563a559f6af5495d9e7ad555d7c8a64d9bb27de77e095697327ef77bdf73ee879cd678b87ce8431f728e7bf3cd37e5273fb947e6dfb140d4fd50975e7ab14c3ff208e7b25875bfdc860dadb2e0ce3be5befbeecff69b7f6f96fa99129baf7ce55f65c488e1924ea7a5bdbd5d56af7e5aaebdee7a59b3e6995de6eb8ed578f8e764f7dd7777daa897ba3f535deef7e39ffcb4d798ea67a52e3775fb74e7a7beecbff1c6266755ee7ffff77fb3f707eedcb953e6cf5f20d75d7f8333663ea76f7fe7bb326eecfe72ec71c7ca9e43873ac728c68f3eb66c17c6c5aab45c49530caebdf66a87bf7a29ee77fde86ef9e10fafeed5fde73efb59b9e082f364ecd8fd65b7dd7673fe98f0eebbef3a9726aae3f339577ab9e9adb7dddeeb9ebb17d7ad932f7ce1b85dee91fdcdaf1f904f7d6ab213db3befbc23175f72993cfcf0efb2b1ba75fab18f7d4cfaf7efefd4fd962d5b1c7eea52dadc1acdcfab12e32757ac902fcd9c2983070f92f7df7fdfe1515bfb8ffb3a0b9d17eafd134ef892fcfbf7bfe7b451afc71e5b26b3be7a6ad15f22f992a872acee131e3870a053bbc71e777cb6fd178f3b56aebcf207ce79b37dfbf66c3cea80422b8995e42ab7aef30376efbd55efbbf7b7aafa5d78ef22f9a7c30e954f7ce213924aa5e4ef6fbd2577dffd6379f37fdfec751f6ca1cb56d5bdd1ea778dbabf57cda7aaaaca61dcd6d6d6678e542d9d7ada6cf9c4befb3a7c541b557f3b76ec90575e795516de7bef2ee76b51f8fc1002108040880490c410e1d2350420e09fc057bf3a4be65d7649f60be56bafbd2e679e75764169524279fffdf7c947f6da4b9e7deeffc9ef1efe9db3d2e8bef225b25074cf3fffbc9c75f6bf6557a072bf04ab2f96efbcf3aeecb9e73fa427f7a5be88df73cfbd72f0c10d3261c204e70b60ee2bff12c87c497cf9e5bfc9e8d1fb64452fb7ad128279977f477efffba5d9b7c78cf984dc31ff36193b766c9f90554c4a7caeb9e6baec31c52451f539ff76d5e7febbc4affa6a6efebd4c9b36cdd944a698242ab9ddbc79b323e2f91cd49762f5a5fbebdf38bdaccd85ca954435c1abafba52befce5539c2ffcea95ffe5fefcf3bf25df3cfdf43e37c1519cd51f09963cf0609657a592a836b55974ef3d326d5aa3d347a1cb2e8f3cf208b9feba6bb32b9ff93275dd75d7c89766ced8653318d59fe2b76efd7a9937efdbbd36e8c9cdab1ab37fffeaec1f4b543b25f87beeb9a7c3a62f81bee1faebe4c413bfe4e44cfda1e1861b6f923beeb8b3e8499c2f896a9cf7dfef94fafa514e0d9c73ee79d94bbeafbce207326bd6bf3afdaf5cb94a9468b91bdee44b62a5b9aa5412150325aaee1f7ad424d5bfaffce1d5b27ddbb6a29278d24927c8a5975cd26be53a1792cad1f3cfbf2067cff9e0f74839bf7bd439f5abc54b64eedc8bfdffe2a407084000023e0920893e01d21c0210089780fbc5d2fde2bf74e92372ea695faf7850b5d274e38d373882a7bec43dfef872b9e8e24b1d31bbe28a7f97fdf7dbcfe9b398fc941a547df154ab79f962e4b6fbf39f57caf133bee4fcb3af5d1efb1a63eddae7e59b679c95dd0864feedb7cab1c77ec1194bad5e5c77fd8df2c0030fc8f9e79d27b367cfca0a42fe4a5631495c78cf4fe48823a6f519bf62a3f2a0e6e88793fb65fcde7b1795425ad10ea2eacbbb5a097357cc72374f513ffbceb72fef25058506cfbf4cd58b24e66ecea26aedfefb7f25175c38373b9c8ae36b5f3bd55971cb1736b5a98bda2dd4bd6cba2f40ab56ad967ffdcaacac689792a4fffaafff92c6c6c6acd8e4d6a21a23ff52d0be369ec98f275f129518ae5fff92fcd33f1de6ac60de74d32d72dbedf39d66eeeaa95a396bfefd5239e6e87f2928895e72556afe6a175ff5ea6ba75cf712f6934ff9b234fdf33ff72989eabc55f7478f1831a268ede65eee9efbbb47adccab15da1f5e75b5a8fba6e75d76a99c78e209d97cab55e5cbe67d5b7ef39bdf963c37380002108040980490c430e9d2370420e09bc0cffff367f2d9cf7ec6e9477df1facf9fdf27175f7c69c5fde6ca66fee576175f74a19c79e619d92facead2cf0be75ee48c91ff25585df6f7c8238fca35d75e27ff74d86172e185e73b977aba2ff5c558ad06dc317f81a855d05c61532b5567cf3947d417f44292a856616eb9f57659b264899c7efa37e4f46f7c3dbb936bae4ca8fbf0eebcf30e19356aa4c3447da154fdba5ff67ff7f043b2efbe1f77fe9dbf9ad397241ed5f4cfa256b0860c19e2b45312a82eebbdf6ba1b64e28483e4bcf3be25e3c68dcd0a642949549cfef4a73fcbd5d75c2ba3468d721e49e05e0a5a491e2b5949cc679a3bf70796fc4a3efde906676e2ab63f3ef9a47cfffb3f903df6d843befded7972d08107662f19ccbd4cd58b24aa4b447fb6e81e672555bdf2453d3796dc5a54ed94a87ffce31fdb25070d0d53e4a2b91764fbcc17ed7c49522bd737df72abdc75d7ddd9dacc1d37bf2e722f35cdafa962275b21495497c4aa5d889504bb7fd4c9cd8d1afbe1dffd977c75d6570a4a6218b95273c8cfa59aa77a5c8aba6f32f7ded56239cffde38c6aaffe7873d34d373b572e7ceb5be7382bc0aee0bbb99d3c7972f63121851e3ba37ec78d1f3f5ed6ac59238f2f7fc2f9630f8ff0a9f8573c0d200081800920890103a53b0840205802b95f7ef3c524a891f2bfe8e65ea698ffb3bffef57f64c6cc2f65bfc4fdea97bf90a9530fc986927b1f57be2ce47e31cf171ab5ba72f5d5d7ca4f7e7a4fb6afef7ee77239edb47fac38a9d7134ffc414ef9f2574a4efbf1658f8aba7454bdf2bf94f62589b9ab5baa5dfefd68ead2c00577cc979123f7ce0a4c5ff724aa03d4e5b36ad320f71108f92bc2b9225e6c427e2471ebd6ad72e9a5f364dbf6edbd2eefcccf61ee4a8f8a25f7f24f2f92a8fac89589dc4b4ef3c7caadb5534ffdaa5c76e925cefd6a8572907fe975eeb308f325b1d0730a2fbbec12e73e3a554ff9e752eea5a695acf4e69f1f4ab66ebdf536b9eaaa2b9d3f70b82b924d4dd3b38fbef8cb5ffeead457eef315ddcb4df32fc50d2a578524f1adb7b6387f0c527ff4c97df595f3fcf3b9d0bd9d4b96fc523efeb18fcbeaa79fce5eee9ecb48ad24aa3f12a94b79837c9e67c95f0a1c00010840a04202486285c0381c02108896405892a8244d6d3a71d8a187ca7efb8de9b589463149fcd5af163b8fd6705ff9f12d5870a75c73edf5d99fe70a5b31492c74795ffe17e6be1e13a056e83ef7b9cfc8673ff319993469920c1bf691ecbd8de54a62eea3093a3b3b456dc0a22e15cc7de5aeea965a49cc17da7c99884212ddb90fde7d702ff92a2450cdfffd3b39f0c0039ce9e6aef87a95c4fc9539f792d35c51cbbf1c33ff3254b519d2bfffe08a6c0a725790d59b2fbcf0824c3be29f9d9f97739ee4ff61c2adf3fccda1f2c5acd8195f4812bff6f5d3b32ba9ae201ffeb9cf3a8fbe702fbf7dedf5d7e49c7f9be36ccaa35e6e6de78b7250b92a24897d9d4f7de53cff7c54b2db74d4bf94fc8598bf21906aa056b3376ffe5f67f550dd6b9c7bef74c90e390002108040040490c4082033040420e09d40fe0a49b972516844b55ba27a54865a1573ef5b2b745c3149cc1fbfd497f37225b1d017d6fc2ff5b9c7a82ff673e69c2dc71d7b6c7637d442732957124bed7aaafa569bada85d37d5ab9424e6738a43125d299f7ac821bd56ad4a55a3daad56ed9efb873ffcb1e83d91c504325fbcdc4b4e17ddbb307bd96bfe264cb97c4bc5a87efed24b2fcbbf1c7d8cb35a5c4efe549bdc4d755c3e7bedb96776d751b5d2f59ffff973b9e4d279e584b0cbe5d86e8dbaf1b88fc23864eac1cea32fdc0d71f2771075dbf5f5488dbe822937578524b1d0aea5c58eab64553b3f5ef50796cf7ce69ffabcdf57ad7a2f7de4d18a76fe2d2b411c04010840c0230124d123389a410002d110b8e69aabe4cba79c9cfd7255ea92cbbeeeef518f96b8e4e2b9f2e10f7fd8095cad68a8fbb6fedffffb8bb372f4c52f1e97bd3f4a77495402f2a3bbeeecf5a5d37dd4c6934f3e29871d7658f6beb6244962fe97f88d1b5f9333ce384bd40a50eea58da52a379799d795443546ee6eab6a43929b6fbe55ce3efbaceceeb8f99b30552a89b92bd3e54ae2bfcd39db79e6a8ba6fce5dc9dc7bef11d95d610b3d8ea318af422b8987371e21b997172b99fdc8473ee23c5ac395ba7f88e915d99d66bd4a62b9b98a5b12d5397bf1c517c98ce3bf5874f324f587834b2fbdacd7637b4ad52b3f8700042010060124310caaf4090108044620fff2b3628fc0c8bf6f2ef75eb0dccd30d497637529df953fbcca89b3d82a57a915b0a05612732f7174e1f575b969febd69eab2c3b9175d927d2c485fab97aadfbe6422e8cb4de35849ccbfafd2bdb73077b751c520ff92e162c5ea47128f3efa5fe49aab7fe8fc6142ada8a98d7ca64cf994f3c708750faadae1523d36c57de58a955aa9cdbf74b9589ce54a62fe39a2ee0ddc6bafbdb297dae63f8ea3d4899c7f7eb89760e65e62a9e6ae76e155ff737f9ecfd595c4b072158424e69f8fb997fb96e2e4fe5cc9e2f1c71f2f9f3faac961ee3e63d1fd79259b06953b26c741000210f0420049f4428d361080406404f2777c54f7f2a85d37d5e580f9afdb6ebb458e3bf60bd9e7e4b9f756a9e716de7acb4d326cd830a749ee657aba4862a14d7972ef5f5371baaba8f9977d967b1f6431492cb5718dda70e5faebaf755684d44bb7cb4dd5463d6ac7577549a37ae5ee065b6a3394b02451f59bfbc70975afa77b0f5efec63eead8521bd7042189aa8f7b7efa63993efd48a7bbb7df7e5baaabfb3b2b7a7d3d3fb1d8b87d6dfa947fffa4db877b8f615f921864ae5a5a9e922f9d705236fc722f172d77e39a77df7dd7795e65eefd84eadcfcfce79be47ffe67ad3cbe7cb93cf8e06f9c2b15fa7a294ee79efb6fce7335d5a365d4abafcb6023fba5cb4010800004440449a40c200001ed09e43f3b4e89a25af1f8d9cffec3f982a604e68c33be29071ffce9ec172db55aa876df54bb08e6dfdb97bf494cee7d5a0a46ee661951ad24aa71d597ce1fffe4a7f2a31fdd2d5f9d35cbb97fb2aeaecec94fee2627b992a8bed8e76e70f2c5e38ecdde5fa6dae5efe0d8d78a53feae9bf98fc0b8e4928bb38fd5d04912d5a63deaf11da79c7292ecbffffed9cb92f39f7798ff5805b5aa77d3cdb7c8abaf6e701e5df085638e763612f9f39fff2cbff8c52fe5d9e79e73b8fb594954edf3455fbdd7d76a51a147603437ff5e6ebce96627968b2f9aebd4f22bafbc2a7ff8e31f65c99207b28f6e28772551f5932fa3ee2f80fcc76294f38ba1d8cec0f93bffe66e88546c5326afb9caef73436babcc99738e0c1a34c87976e3a1530fe9f3f987b9732df71118aa8dfa83d3d5575fe33c5225ffb135ee1f52d4eea9ead98f9ffef4a7e5431fda5d7ef0832b7b8965fe78a52ea92f272f1c03010840c02f0124d12f41da4300029110b8e5e61b9dfb06ddbfb6171b547d09577f8dfffa374ecf3eaa2277f74a2599bff9ed4372fd75373882907b3fa2ea378e7b124b4154cf63fbe61967398f94c8bf244fad54ccbbfc3b525353d3eb597aaacf72ef4954c7aa67f41d71c4b43e37d7c88d31ae95c4529cd4cfd5e6286a67d6dbe7df913dfc6ba79d2a975c7251f6f1127df593fb10f42024b1d0f330732f83ce8f23ffb1277dc5a96af8673ffb4fe7197fea558924e6cba83b46fe634fca615d4c12f31f7b92fb078b629b3279cd957a0ea67af488fb3c4e377e574e37b66ef42d892aee9b6fba41468c1851128fba1cf51ba79f29dff9f6bc5ee79512cb9b6fbec511c5430e39d87934888a3d954a15acdd9203710004200081100820892140a54b0840201c023ff8c1f7e594934f7264a8af975a59fbc31f9f948b2ebaa4d7655e6ae39acb2ebdb8d783efdd3e9418a8fba65c01cd7df879542b896a438f542a2d4387eeb1cbd49404aaf92c7b7cb9f3337569e08feffe91f3080f759f57fe4b315073513fcb97b96232a12ed99c7ffb6d3276ec072b726edf4abcd4e5bb9ffad464e72d5d2551ed12f9a3bb7f2c37def88fd5b7dc979216b53babfbb0f3fc9fab3a78eeb9e7e4bcf32fccaed0f95d495463e4af54177bc484caed8d37de204dff3cbdcf3f8828415cbefc0939ebec39d93f825422892aa6dce738aa7fe73f8ea3dc33b89824e6af58e69e57c524518ded2557aa5dfe6ec86eadaa4bb2d525beb99be554babba9cb44ad0a5e7ac92505cf55f71875ce5e75d535b2e481079d6796de74e3f5a22e7b2f74beba6dd479ab2ea5cf7dc44eb979e038084000024113401283264a7f108040a804d45fdebf3aeb2b72f0c1074b5ddd10e78bb4fa72af56cc5e7cf145e712d4c54b1e281883128433cf3843f6d9a7de79a0b85a6178e5d557e5fefb7f29eade20f51c37f5ca7d98785492a836eeb86cdee5cef3fcc68f1fe7888c8a433d785b5d16b966cd33bde6a4564bbe7df965d2d8d898dd21525daeaabef83efad832b97cde65d92fb1aa8fe3677cc9695f4a2654bf975e7ab11c31add1116a25cf1b366c903b16dc2993274dce3e02c37d94c11d77dce9f45b8a53a99ff75534f99256e838f5e5faedb7df91969616e772dd7c56b96d547fa79e36dbb97771b7dd76737ea4ea405d6afa9bdffe566ebf7d7e56bcd4cf8290c4dc95df721f31f1cd6f7e434e3cf104f9e8e8d1d9fb1815737509a5aad7bbeebabb178a5279cde796ffec3e772758f732db724fe2fcbce65eaa9dbfb297bb9b6b294974d957922bd5466dcc73d1dc0ba5a1618a730e29a1deb2658bdcfde39f48fe6337bc4aa23bce374fff86f3871a77f319b70e9ff8c31f64fefc3bb27f6850c72bf95797901f77dcb1ceef9f8103073ac2a87e77a94d8cd425c40befbd57d4864fbc20000108e8400049d4210bc4000108248e40395f92758392bbe149fe65acbac54a3cc509e4ef905be8a1f530840004200081e4124012939b7b660e0108c448403749542b66f32ebf4cdefafb5bb272e52af9affffe6f59b1a2c521a45617bff2af5f96d34e9b2d83070f76de2bf4c88e187132741904d4bd88ea9e56b5d14fee4644b92be76574c321108000042090000248620292cc14210001fd08e82689f9bb9b162396bfb98b7e7489a81081c71efdbdb3036cfeabd83d929084000420008164124012939977660d0108c44c40374954382ebe78aea8fbacfadad8c545a6ee9fbce0c2b945effd8b192fc3172050685397f7de7b4f7e78d535cebdbcbc200001084000022e0124915a800004201003011d25516150979daa9d60d58e8cb5b5b5d91d36d5a61c6d6d6dcea6386ae7d0620f088f0127439641e0de853f95c30fff9c935395cf975e7ac9d9e887cd52ca80c72110800004124600494c58c2992e04200001084000021080000420008162049044ea0302108000042000010840000210800004b20490448a010210800004200001084000021080000490446a00021080000420000108400002108000047625c04a22550101084000021080000420000108400002ac24520310800004200001084000021080000420c04a22350001084000021080000420000108400002450870b929e5010108400002108000042000010840000259024822c500010840000210800004200001084000024822350001084000021080000420000108400002bb12602591aa80000420000108400002108000042000015612a901084000021080000420000108400002106025911a80000420000108400002108000042000812204b8dc94f280000420000108400002108000042000812c01249162800004200001084000021080000420000124911a80000420000108400002108000042000815d09b092485540000210800004200001084000021080002b89d40004200001084000021080000420000108b092480d400002108000042000010840000210804011025c6e4a79400002108000042000010840000210804096009248314000021080000420000108400002108080be92387bf62cd9b66dbb2c5ebca4579ad4fb7bd4ede1bcd7d9d9298f2d5b266bd73e9f3d66ead443a4a1618aa45369e7bd0dadadbbf441de21000108400002108000042000010840a03801ad56125d11cc17bc993367c8f061c3b262a88eebdf7f803437374b6beb4619376eac4c6b6c944d9b373b62e80aa392c8a54b1fa10620000108400002108000042000010840a04c025a48a22b79e97e69e9ca7465654fcdc1fdd98bebd665852fff3d2591757575596954ed0abd5726130e8300042000010840000210800004209058025a48a212ba41836a65d9b2c7a5a9a949dadadab2978aaa55c1c99326c9d36bd6484bcb53d944e55e96aafe5bbd162e5c94fdb96a3771e20459befc895e97a52636d34c1c0210800004200001084000021080401904b4904437cefafa51bb48e2f4e947ca7e63c6ec720fa22b8685c452f5d7975c96c184432000010840000210800004200001082496009298d8d43371084000021080000420000108400002bb124012a90a08400002108000042000010840000210c812d05e1283be27b1baba5a060ce85fb204de7fbf53d4b1a95455c96339000210d895404d4d8da8f3a8a7a71b3c1080408504387f2a04c6e110c823c039444940c03b0175fe682f8941ef6e9a4aa5a4aaaab4f82941cc6432d2d3d3e39d302d21906002b5b5b5d2dede2edddd486282cb80a97b24c0f9e3111ccd20f07f0438872805087827a0ce1fed25514d2f8ee7242a83eeecece40baef7faa265c209a81d8bdbdb3ba4abab2be124983e042a27c0f95339335a40209700e710f50001ef04d4f9638424aa29aadd4cf7a8dbc399ad92b7c7962debf5680b75596a43c31449a7d2ce311b5a5bb38fd1f0820849f4428d3610f880001fd0540304bc13e0fcf1ce8e961050043887a803087827a09d247a9f4af02d91c4e099d263b208f0019dac7c33db600970fe04cb93de9247807328793967c6c11140128bb04412832b347a4a26013ea0939977661d0c01ce9f6038d24b7209700e2537f7ccdc3f01241149f45f45f400813e08f0014d6940c03b01ce1fefec680901458073883a80807702482292e8bd7a6809811204f880a64420e09d00e78f7776b4840092480d40c01f01241149f45741b4864011027cc9a53c20e09d00e78f7776b4840092480d40c01f01241149f45741b4860092480d4020140248622858e9344104388712946ca61a38012411490cbca8e810022e013ea0a905087827c0f9e39d1d2d21c04a223500017f04904424d15f05d11a02ac2452031008850092180a563a4d1001cea104259ba9064e00494412032f2a3a84002b89d40004fc13e00bae7f86f4906c029c43c9ce3fb3f74700494412fd5510ad21c04a223500815008f0053714ac749a20029c43094a36530d9c00928824065e547408015612a90108f827c0175cff0ce921d9043887929d7f66ef8f00928824faab205a438095446a0002a110e00b6e2858e9344104388712946ca61a38012411490cbca8e81002ac24520310f04f802fb8fe19d243b209700e253bffccde1f01241149f45741b486002b89d400044221c017dc50b0d2698208700e2528d94c357002482292187851d121045849a40620e09f005f70fd33a4876413e01c4a76fe99bd3f02482292e8af82680d015d57125369e919375364ef0691a1fb9327085446e0cdbf88bcbe4aaad62ea9ac5d8047f305374098749548029c43894c3b930e880092882406544a7403815d09c4f6015dbd9bf41c778ff4abdd4dd2d5223da934e981406504ba32d2bdb347325b3649d5c36755d636a0a3633b7f028a9f6e20103701cea1b833c0f826134012914493eb97d8352710d707744fe315d27fdf8992daf3a39a13223cdd0974bdf182649efb6f91353f8e3cd4b8ce9fc827ca8010088900e7504860e9361104904424311185ce24e32110cb07f487eba5ea0bf3a5ffa88fc5336946b58ec0fb1b3788fcf2cb221d6f473ab758ce9f4867c86010089700e750b87ce9dd6e0248229268778533bb5809c4f254e8778d000020004944415401fdf1232535f914a9fe4443ac7367707b08ec7ce57fa4fbf7978b6c5917e9a462397f229d218341205c029c43e1f2a577bb09208948a2dd15ceec622510c70774cf01274a7af4a7a47ac2e7639d3b83db43a073dd4ae959719bc81b6b229d541ce74fa413643008844c80732864c0746f3501241149b4bac0995cbc04e2f8804612e3cdb98da32389366695392581401c9f4149e0ca1c9341004944129351e9cc321602717c402389b1a4daea419144abd3cbe42c2610c76790c538995ac20820894862c24a9ee94649208e0f682431ca0c27632c243119796696f61188e333c83e8acc28a90490442431a9b5cfbc232010c70734921841621336049298b084335d6b08c4f119640d3c2692780248229298f8930000e11188e3031a490c2f9f49ed19494c6ae699b7e904e2f80c329d19f143c025802422899c0d10088d401c1fd0486268e94c6cc748626253cfc40d2710c76790e1c8081f025902c648627dfd28696a6a92c1830639c16fddb64d9a9b9ba5b57563763253a71e220d0d53249d4a3bef6d686d95c58b97784e774d4d8d7476764a7777b7e73e680881241388e3031a494c72c585337724311caef40a81b009c4f11914f69ce81f0251113042125d4154505c319c397386d4d5d565ff3d6edc5899d6d8289b366f76c4d015c6b56b9f97a54b1ff1c41349f4848d4610e8f557a8f6f60ee9eaea8a8c0a921819eac40c84242626d54cd4320248a26509653a911230421295f04d9e34499e5eb3465a5a9e7200b9e2f8eaabaf3a12982f8dea9842ef55421749ac8416c742605702717c4023895462d00490c4a089d21f04a22110c767503433631408844fc008499c3efd48d96fcc18796cd932512b83ee6bf6ec59b26ddb7667e550fdb77a2d5cb828fb73259713274e90e5cb9fe8d5ae5cac4862b9a4380e028509c4f1018d24528d4113401283264a7f108886401c9f41d1cc8c5120103e012324b1d84a6267e7fbb26cd9e3cefd8a6d6d6dbdee412cd4ae12a4486225b4381602bb1288e3031a49a41283268024064d94fe20100d81383e83a29919a340207c02464862a17b12d5eae281071c205bdab62089e1d7092340c01381383ea091444fa9a25111024822e501013309c4f119642629a28640e13ff4578dd8bbbe477738f9bb9b2a39745f95ae24565757cb8001fd4b4e3993e992743a2d5555250f0df1802aa9ea2722a9588308717e741d0a816e919e4cfcbbf20e1c582b1d1d1dd2dd1dddc6359d6366484ffd2725357e7a2868e934790432eb574bf5eabba4df9bcf453af938ce9f4827c86010089900e750c880e9de6a02eafc314212f3b3e04aa37b896925f724a65229a92ac3fc944c663219e9e989dea1abfa55c9878f182203f7df4d52e994088e68f58918f8e47a44ba33ddf2f663efc88ebf6e0fbcfb723bacadad95f6f6f6481f23d33dfe0449ed3359fa1d7454b961721c048a12d8b96e9548cbed52b5f9994849c571fe443a41068340c804388742064cf7561350e78ff692e83edee2c575ebb28fb3c8bfdfd0aadd4d5322f5e7d6cb6e037793811f192855ac225a7d128635b99def75cafb9d3ba56df51679ebe1b7c21aa668bf715ceac3e5a6b1a4daea41b9dcd4eaf432398b09c4f11964314ea696300246dc93a872a2560afbf71fe03c1751bdd446356ad31a7737539b9e935877449d0c9950271ffae8ee092b47a61b06817737bf2bad776e949d6f7586d13d92183955068c9a0092183571c68340300490c46038d24b320918238985ee49cc7ddc854a9f5a5d6c689822e954dac9e686d6d65ebb9d569ae2587637ad12a93fbf5e3ebcd787a55fadba19911704fc1178f7c5f7e4add57f97779f7ad75f471e5ac7f101cd4aa28744d1a4280124910281809904e2f80c3293145143605702c648621cc98b431253fd5332f29c913274f4d038a6cc981612d8fad236d9fede5679e3a79b229f5d1c1fd04862e469b67e4024d1fa1433414b09c4f11964294aa6954002486291a4c722893529193907494ce0b918da94df5bb7553abadbe5b5db5f0b6d8cbe3a8ee3031a498c3ccdd60f88245a9f6226682981383e832c45c9b41248004944121358f6c99a329298ac7c33dbe0092089c133a54708444100498c823263d84a004944126dad6de6f57f0490444a0102fe082089fef8d11a0271114012e322cfb83610401291441bea983914218024521e10f0470049f4c78fd610888b0092181779c6b58100928824da50c7cc0149cc12e09e444e87a00920894113a53f08444300498c8633a3d84900494412edac6c669525c04a22c500017f0490447ffc680d81b80820897191675c1b08208948a20d75cc1c5849642591b320340248626868e91802a112401243c54be7961340129144cb4b9ce9b192480d40c01f0124d11f3f5a43202e0248625ce419d7060248229268431d330756125949e42c088d0092181a5a3a8640a80490c450f1d2b9e504904424d1f212677aac24520310f0470049f4c78fd610888b0092181779c6b58100928824da50c7cc8195445612390b422380248686968e21102a01243154bc746e3901241149b4bcc4991e2b89d40004fc114012fdf1a33504e2228024c6459e716d208024228936d431736025919544ce82d0082089a1a1a56308844a00490c152f9d5b4e004944122d2f71a6c74a223500017f0490447ffc680d81b80820897191675c1b08208948a20d75cc1c5849642591b320340248626868e91802a112401243c54be7961340129144cb4b9ce9b192480d40c01f0124d11f3f5a43202e0248625ce419d7060248229268431d330756125949e42c088d0092181a5a3a8640a80490c450f1d2b9e504904424d1f212677aac24520310f0470049f4c78fd610888b0092181779c6b58100928824da50c7cc8195445612390b422380248686968e21102a01243154bc746e3901241149b4bcc4991e2b89d40004fc114012fdf1a33504e2228024c6459e716d208024228936d431736025919544ce82d0082089a1a1a56308844a00490c152f9d5b4e004944122d2f71a6c74a223500017f0490447ffc680d81b80820897191675c1b08208948a20d75cc1c5849642591b320340248626868e91802a112401243c54be7961340129144cb4b9ce9b192480d40c01f0124d11f3f5a43202e0248625ce419d7060248229268431d330756125949e42c088d0092181a5a3a8640a80490c450f1d2b9e5048c92c4d9b367c91e757b3829e9ecec94c7962d93b56b9fcfa668ead443a4a1618aa45369e7bd0dadadb278f112cf29aca9a971c6e9eeeef6dc47a50d533529193967a40c1d3db4d2a61c0f8182045849a43020e08f0092e88f1fad2110170124312ef28c6b0301632471e6cc19327cd8b0ac182a61ecdf7f803437374b6beb4619376eac4c6b6c944d9b373b62e80aa392c8a54b1ff1942b24d113361a69460049d42c2184631c0124d1b8941130041c024822850001ef048c90c4fafa51d2d4d4246d6d6dd99541570a5f5cb7ce91402591757575596954480abd57092a24b1125a1cab2b012451d7cc1097290490445332459c10e84d0049a42220e09d803592a85616d56be1c245591a6a3571e2c409b27cf913bd2e4b2d171792582e298ed3990092a8737688cd040248a20959224608ec4a0049a42a20e09d801192e8ae0ae65e6e9a7bf9e9b66ddb765969546d94244e9e34499e5eb3465a5a9eaa9812925831321a68480049d430298464140124d1a874112c04b20490448a0102de09182389ae28ee535fefcc76ebb66dd94b4b0b5d8e8a247a2f0a5ada450049b42b9fcc267a024862f4cc1911024110401283a0481f4925608424ba12d8d9f97ef672d2e9d38f94030f3840fef2d7bfca0b2fbc50d14a627575b50c18d0bf64ce33992e49a7d3525555f2d0c00ea81a909221a70e6177d3c088d2d18e9777c8f6cc7679fb9eb6c8610c1c582b1d1d1dd2dddd15d9d89d6366484ffd2725357e7a64633290dd0432eb574bf5eabba4df9bcf453ad138ce9f4827c86010089900e750c880e9de6a02eafca91ab1777d8fceb35442b8df9831bb3cf222f73ec44aee494ca552525586f92999cc6432d2d3131d1ef5088ce1670e4712752e48c362dbba7eabb477b5cba6059b228fbcb6b656dadbdb237d8c4cf7f81324b5cf64e977d05191cf9701ed24b073dd2a9196dba56af333914e308ef327d2093218044226c039143260bab79a803a7fac90447637b5ba4e999c0f025c6eea031e4d21a09ecbbb6ea5f4acb84de48d3591f2e052b948713398850438872c4c2a538a8c8015979baa4760f09cc4c86a86810c2380241a9630c2d58e0092a85d4a08080265114012cbc2c441102848c008495491bbf7250e1e34c89948577797ac5cb9aad7aea56a37d3868629924ea59d6336b4b6669fabe825ffec6eea851a6d74238024ea9611e2318d0092685ac6881702ff208024520910f04ec01849f43e45ef2d9144efec68a90f0124519f5c10899904904433f346d4104012a9010878278024166187247a2f2c5aea430049d427174462260124d1ccbc11350490446a0002de09208948a2f7eaa1a51104904423d244901a134012354e0ea141a008012491f280807702482292e8bd7a6869040124d1883411a4c60490448d934368104012a9010884420049441243292c3ad5870092a84f2e88c44c0248a29979236a08b092480d40c03b01241149f45e3db43482009268449a0852630248a2c6c9213408b092480d40201402482292184a61d1a93e0490447d72412466124012cdcc1b51438095446a0002de09208948a2f7eaa1a51104904423d244901a134012354e0ea1418095446a0002a110401291c4500a8b4ef5218024ea930b22319300926866de881a02ac24520310f04e00494412bd570f2d8d2080241a912682d4980092a87172080d02ac2452031008850092882486525874aa0f0124519f5c10899904904433f346d4106025911a80807702482292e8bd7a6869040124d1883411a4c60490448d934368106025911a804028049044243194c2a2537d082089fae48248cc2480249a9937a286002b89d40004bc1340129144efd5434b2308208946a48920352680246a9c1c4283002b89d40004422180242289a114169dea430049d427174462260124d1ccbc1135045849a40620e09d009288247aaf1e5a1a41004934224d04a931012451e3e4101a045849a40620100a012411490ca5b0e8541f0248a23eb920123309208966e68da821c04a22350001ef04904424d17bf5d0d2080248a2116922488d0920891a2787d020c04a22350081500820894862288545a7fa104012f5c905919849004934336f440d015612a90108782780242289deab8796461040128d4813416a4c0049d438398406015612a9010884420049441243292c3ad5870092a84f2e88c44c0248a29979236a08b092480d40c03b01241149f45e3db43482009268449a0852630248a2c6c9213408b092480d40201402482292184a61d1a93e0490447d72412466124012cdcc1b51438095446a0002de09208948a2f7eaa1a51104904423d244901a134012354e0ea1418095446a0002a110401291c4500a8b4ef5218024ea930b22319300926866de881a02ac24520310f04e00494412bd570f2d8d2080241a912682d4980092a87172080d02ac2452031008850092882486525874aa0f0124519f5c10899904904433f346d4106025911a808077024648e2f4e947ca81071c5070965bdab6c8c2858b9c9f4d9d7a8834344c91742aedfc7b436bab2c5ebcc4339d9a9a1ae9ecec94eeee6ecf7d54da30559392917346cad0d1432b6dcaf11028480049a43020e08f0092e88f1fad2110170124312ef28c6b03012324b11068258ee3c68d95952b57494bcb53ce7f4f6b6c944d9b373b62e80ae3dab5cfcbd2a58f78ca1592e8091b8d342380246a9610c2318e0092685cca0818020e0124914280807702464a62be10aae9cf9c3943eaeaeaa4b9b9595a5b373a440abd57092a24b1125a1cab2b012451d7cc1097290490445332459c10e84d0049a42220e09d809192387bf62ce9df7f402f2154efa9977be9a9fa6fb59a3871e20459befc09512b8a95be90c44a8971bc8e0490441db3424c261140124dca16b142e003024822d50001ef048c93c4429791d6d78f92a6a626696b6beb750fa23a76f2a449f2f49a35ce25a995be90c44a8971bc8e0490441db3424c261140124dca16b1420049a40620100401e324b1d025a4486210a5401fb61240126dcd2cf38a8a0092181569c68140b00458490c9627bd258b805192d8970c562a89d5d5d5326040ff9299ce64ba249d4e4b5555c943033ba06a404a869c3a84dd4d03234a473b5ede21db33dbe5ed7bda2287317060ad747474487777576463778e99213df59f94d4f8e9918dc9407613c8ac5f2dd5abef927e6f3e17e944e3387f229d2083412064029c432103a67bab09a8f3a76ac4def53d26ccb2d8e5a395dc93984aa5a4aa0cf3533299c964a4a7273a3cea1118c3cf1c8e249a509086c4b875fd5669ef6a974d0b36451e716d6dadb4b7b747fa1899eef127486a9fc9d2efa0a3229f2f03da4960e7ba55222db74bd5e667229d601ce74fa413643008844c80732864c0746f350175fe182389eab117fb8d19238f2d5bb6cb4634ec6e6a759d32391f04b8dcd4073c9a424044b8dc943280809904b8dcd4ccbc11b51e048cbadcb4d8232d784ea21e054514fa114012f5cb091199450049342b5f440b01970092482d40c03b01a324b1d025a5b95377773e4da7d2cedb1b5a5b7bed765a29267637ad9418c7eb480049d4312bc464120124d1a46c112b043e208024520d10f04ec02849f43e4d6f2d91446fdc68a517012451af7c108d79049044f37246c41050049044ea0002de09208945d82189de0b8b96fa104012f5c905919849004934336f440d0124911a80807702482292e8bd7a6869040124d1883411a4c60490448d9343681028420049a43c20e09d009288247aaf1e5a1a41004934224d04a931012451e3e4101a0490446a0002a110401291c4500a8b4ef5218024ea930b22319300926866de881a02ac24520310f04e00494412bd570f2d8d2080241a912682d4980092a87172080d02ac2452031008850092882486525874aa0f0124519f5c10899904904433f346d4106025911a80807702482292e8bd7a6869040124d1883411a4c60490448d934368106025911a804028049044243194c2a2537d082089fae48248cc2480249a9937a286002b89d40004bc1340129144efd5434b2308208946a48920352680246a9c1c4283002b89d40004422180242289a114169dea430049d427174462260124d1ccbc1135045849a40620e09d009288247aaf1e5a1a41004934224d04a931012451e3e4101a045849a40620100a012411490ca5b0e8541f0248a23eb920123309208966e68da821c04a22350001ef04904424d17bf5d0d2080248a2116922488d0920891a2787d020c04a22350081500820894862288545a7fa104012f5c905919849004934336f440d015612a90108782780242289deab8796461040128d4813416a4c0049d438398406015612a9010884420049441243292c3ad5870092a84f2e88c44c0248a29979236a08b092480d40c03b01241149f45e3db43482009268449a0852630248a2c6c9213408b092480d40201402654be2cc19c7cb95575e210f3df4b05c38f7a25ec15c7fddb572cc3147cbbc7997cbe2250f8412681c9dd6d4d4486767a774777747367caa262523e78c94a1a38746362603d94d0049b43bbfcc2e7c024862f88c19010261106025310caaf499140248222b8949a9f5c4ce13494c6cea9978400490c48040d20d0422268024460c9ce1ac22505212efffc5cfe5b0c30e2d39e975ebd6cbe18d47943ccea403584934295bc4da17012491da80803f0248a23f7eb486405c0490c4b8c833ae0d044a4aa23bc962979bda00a2d01c90445b339bac792189c9ca37b30d9e0092183c537a8440140490c428283386ad04ca96445b01149b179298c4acdb376724d1be9c32a368092089d1f2663408044500490c8a24fd249140459238f7c20be4ecb3cf94eaeaea5d586ddbb69d8d6b02a82036ae0900225df4228024521010f0470049f4c78fd610888b0092181779c6b58140d99278e8a153e5d65b6e92f7dedb6addbd877d259295441b4a9c392089d40004fc114012fdf1a33504e2228024c6459e716d2050b624724f6234e96625311ace491a05494c52b6996b180490c430a8d22704c227802486cf9811ec2550b624ba2b898f3ffec42ecf498c0acfcc9933649ffa7a67b8aeee2e59b97295b4b43c951d7eead443a4a1618aa45369e7bd0dadadb278f112cfe1b192e8191d0d352280246a940c42319200926864da081a028224520410f04ea06c4954435c7fddb572cc3147c772efe1ecd9b364f0a0c1f2d8b265b276edf3a28471f8b061d97f8f1b3756a63536caa6cd9b1d317485511dbb74e9239e0821899eb0d148330248a26609211ce3082089c6a58c8021e0104012290408782750b624ba979baa06855e616e5c5348f85c297c71dd3a47029534d6d5d5497373b3b4b66e74422cf45e25a890c44a6871acae0490445d33435ca61040124dc9147142a0370124918a80807702654ba2f721fcb79c3efd48d96fcc98ecaa61a11ed54aa37a2d5cb828fb63259713274e90e5cb9f70561f2b7d21899512e3781d0920893a6685984c2280249a942d6285c007049044aa0102de09182189ee8ae0ebafbf2efbefb79f33dbdc7b12ebeb4749535393b4b5b5f5ba075149e2e44993e4e9356b7addbb582e2e24b15c521ca733012451e7ec109b0904904413b2448c10d8950092485540c03b016324516d58b3a56d4b76a55089e3c8917b3b9bd7bcf6da6b48a2f71aa0a5e5049044cb13ccf442278024868e980120100a01243114ac749a1002654b629cf72416bab7d05d3decec7c5f962d7bbc2249acaeae960103fa974c7126d325e9745aaaaa4a1e1ad80155035232e4d4213274f4d0c0faa4a36413d8f1f20ed99ed92e6fdfd316398881036ba5a3a343babbbb221bbb73cc0ce9a9ffa4a4c64f8f6c4c06b29b4066fd6aa95e7d97f47bf3b948271ac7f913e904190c022113e01c0a1930dd5b4d409d3f5523f6aeeff13a4b258fdffdeeb765d1a2ff90ebaebfc16b3745dbf5b5014dee7d8895dc93984aa5a4aa0cf3533299c964a4a7c7339e8a79a8e7240e3f7338925831391af44560ebfaadd2ded52e9b166c8a1c526d6dadb4b7b74b7777776463778f3f4152fb4c967e071d15d9980c6437819deb5689b4dc2e559b9f8974a2719c3f914e90c120103201cea19001d3bdd504d4f9e34b12151df5688cc30fffac9c73ee79b262454be0c00a6d40937f1f22bb9b068e9d0e2d21c0e5a696249269c44680cb4d6343cfc010f04580cb4d7de1a371c209947db969314e513c3f317fa530f79ec49696a784e72426bc92997e9f0490448a0302fe082089fef8d11a0271114012e322cfb836100844121f5ff6a8ecbefbe0d056125dd04a14f7a8dbc3f967eeeea6eecfdde729a65369e7ad0dadadbd763bad3461ec6e5a29318ed7910092a8635688c9240248a249d92256087c400049a41a20e09d40d992586ce39a9d3b77cafcf90b42bb27d1fbf4fcb54412fdf1a3b51e0490443df24014e6124012cdcd1d91279b009298ecfc337b7f04ca96447fc398d91a4934336f44dd9b0092484540c01f0124d11f3f5a43202e0248625ce419d706024862912c2289369438734012a90108f8238024fae3476b08c44500498c8b3ce3da40a06249bcff173f97c30e3bb4d7dc9f7c72859c78d22936f0e8350724d1ba94267242486222d3cea403248024060893ae20102101243142d80c651d818a245109e2c4891365debccb65f192071c18eebd8acf3efbac75a288245a57ef899c109298c8b433e90009208901c2a42b08444800498c1036435947a06c497465f0a1871e960be75ed40b44148fc088833c92180775c60c9a0092183451fa4b1a012431691967beb61040126dc924f38883009258843a921847493266d00490c4a089d25fd208208949cb38f3b5850092684b2699471c04ca9644151c979b869fa2544d4a46ce192943470f0d7f30464804012431116966922112401243844bd7100891009218225cbab69e404592e88a221bd78457174862786c93da339298d4cc33efa00820894191a41f08444b00498c9637a3d945a06249b46bfac567c3e5a649cab6bd734512edcd2d338b860092180d67468140d00490c4a089d25f9208208945b28d2426e954b077ae48a2bdb96566d1104012a3e1cc2810089a0092183451fa4b1281b224b1d0cea6871e3a556ebde52687d539e79e272b56b458c70d49b42ea5899c109298c8b433e90009208901c2a42b08444800498c1036435947a0a424cebdf00239fbec33e5cf7f5e59f039888f2f7b54468c18d1ebd989b65042126dc964b2e78124263bffccde3f0124d13f437a80401c0490c438a833a62d044a4aa29240f53abcf1883ee75cce31260243124dcc1a31e7134012a90908f8238024fae3476b08c44500498c8b3ce3da40a0a82416baccb4d0a4afbfee5a39e698a3ad5b4d44126d2871e68024520310f0470049f4c78fd610888b0092181779c6b581009258248b48a20d25ce1c90446a0002fe082089fef8d11a0271114012e322cfb83610282a89eee6342fbdf472c1fb115d00f7ffe2e7b2efbe1fb76e031b24d18612670e48223500017f0490447ffc680d81b80820897191675c1b0894bc275109e0c48913fbbc94b45c91341116926862d688399f0092484d40c01f0124d11f3f5a43202e0248625ce419d706022525514d526d4cf3d18f8e96f9f317c875d7df909db77bcfe2b66d5bad5b45549344126d2871e68024520310f0470049f4c78fd610888b0092181779c6b581405992a826ea3e0aa3baba3a3bef9d3b77ee228e364071e78024da94cde4ce05494c6eee9979300490c46038d20b04a2268024464d9cf16c2250b624da34e972e78224964b8ae374268024ea9c1d6233810092684296881102bb124012a90a0878278024166187247a2f2c5aea430049d427174462260124d1ccbc11350490446a0002de09208948a2f7eaa1a51104904423d244901a134012354e0ea141a008012491f280807702482292e8bd7a6869040124d1883411a4c60490448d934368104012a9010884420049441243292c3ad5870092a84f2e88c44c0248a29979236a08b092480d40c03b01241149f45e3db43482009268449a0852630248a2c6c9213408b092480d40201402154be2fdbff8b91c76d8a14e30f7dd77bf8c1a3552f6ddf7e3a13f2771ead443a4a1618aa453e92c88aeee2e59b97295b4b43ce5bc977fcc86d65659bc788967706c5ce3191d0d352280246a940c4231920092683bcfbc60000020004944415464da081a02c24a22450001ef042a92c4c7973d2abbef3e58eebceb6eb9f082f3e5a1871e96077ffd6bb9f5969be4bdf7b6cae18d47788fa444cbe9d38f94fdc68c91c7962d93b56b9fdfe5e871e3c6cab4c646d9b479b32386ae30aa63972e7dc4535c48a2276c34d28c0092a8594208c7380248a27129236008380490440a0102de09942d8933671c2f575e798523867ffad39fb2ff7de1dc8be4faebae95638e395ae6cdbb5c162f79c07b34455ace9c3943eaeaeaa4b9b9595a5b37ee7264a19f976a532a5024b114217e6e020124d1842c11a3ce0490449db3436c10e89b0092487540c03b01632471f6ec59ce2c172e5c5470b6857eae5613274e9c20cb973f5170f5b1143624b114217e6e020124d1842c11a3ce0490449db3436c104012a901088441a06c495483abfb11d5fd87b9979bbaab8acf3efbac9c78d22961c428f5f5a3a4a9a949060f1a94ed3ff77e44f7e76d6d6dbdee4154923879d224797acd9aec7d8b9504882456428b6375258024ea9a19e232850092684aa6881302bd09b092484540c03b818a24510da32e2d3df9e4137b8df8e4932b42134435907bbfe1d66d5bb32b89ea1e45f5bedab8e6b5d75e73241249f45e08b4b4970092686f6e9959340490c46838330a0482268024064d94fe9244a06249d4058ebb7ad8d9f9be2c5bf63892a84b6288433b0248a276292120c308208986258c7021f07f0490444a0102de09182b896acab9f72156724f627575b50c18d0bf24b54ca64bd2e9b45455953c34b003aa06a464c8a94364e8e8a181f54947c926b0e3e51db23db35ddebea72d72100307d64a474787747777453676e79819d253ff49498d9f1ed9980c643781ccfad552bdfa2ee9f7e673914e348ef327d2093218044226c039143260bab79a803a7faa46ec5ddfa3f32c0bdd5b987f1f6225bb9ba65229a92ac3fc944c663219e9e9890e4faa2625c3cf1c8e24ea5c9086c5b675fd5669ef6a974d0b36451e796d6dadb4b7b74b7777776463778f3f4152fb4c967e071d15d9980c6437819deb5689b4dc2e559b9f8974a2719c3f914e90c120103201cea19001d3bdd504d4f9539624ba8fc0504b8fc55eebd6ad0ffc7989b99796babb9b2a291c3e6c58f6b9893c27d1ea3a65723e0870b9a90f783485808870b929650001330970b9a99979236a3d085474b9a9dadd74e2c489bd9e87e8caa3daddf4d6db6e975b6fb949de7b6f6b68a2e8ee70dad9d999154417a55a716c689822e954da796b436b6bafdd4e2b45ceeea69512e3781d0920893a6685984c2280249a942d6285c007049044aa0102de09942d89ae0c3ef4d0c372e1dc8b7a8da8763c3de698a31d793cf8e083b3ffbd78c903de23d3a02592a8411208c1370124d137423a4838012431e105c0f48d2580241a9b3a02d780009258240948a206154a08be092089be11d241c2092089092f00a66f2c0124d1d8d411b80604ca9644156ba9cb4d4f3ce914e7987df7fdb89c73ee79b262458b0653f41e0292e89d1d2df5218024ea930b22319300926866de881a024822350001ef042a9244358cbab4f4e4934fec35e27df7ddef5c82aa04f1d39f6e90f9f317c875d7dfe03d2a4d5a22899a2482307c1140127de1a33104d8b8861a8080a1049044431347d85a10a85812b5883aa22090c48840334ca80490c450f1d2790208b09298802433452b09208956a69549454400492c021a498ca80a192654024862a878e93c010490c4042499295a490049b432ad4c2a22021549e2dc0b2f90b3cf3e53d443e6f35fdbb66deff5688c88e20f7518243154bc741e1101243122d00c632d0124d1dad43231cb092089962798e9854aa06c493cf4d0a9ce33105f7ae9e5ecf3101f7ffc09f9d39ffe24575e7985147a3446a89147d0399218016486089d0092183a6206b09c0092687982999eb50490446b53cbc4222050b624e63f27f1f1658fca9b6fbe296a4753b599cde1877fd68a1d4d7399238911542043844e00490c1d3103584e0049b43cc14ccf5a0248a2b5a965621110f02c896a27d3bdf6da4b0e6f3cc291c4638e399acb4d034858aa262523e78c94a1a38706d01b5d40400449a40a20e08f0092e88f1fad2110170124312ef28c6b0381b225514d56ad1eaa57be187ee94b33ad7936222b8936943573c8258024520f10f0470049f4c78fd610888b0092181779c6b581404592987b5fa2bacc5449e398319f909d3b775af36c4424d186b2660e48e2a7a47ac2e7290408044200490c04239d402072024862e4c819d022021549a245f32e6b2adc935816260ed29c002b899a2788f0b42780246a9f2202844041024822850101ef0490c422ec9044ef85454b7d082089fae48248cc2480249a9937a2860092480d40c03b818a2431778753f7d117aa031b9f91a8902289de0b8b96fa104012f5c905919849004934336f440d0124911a80807702154962eec6356a77d38913273a3b9aaa8d6bdc9d4ebd87a25f4b2451bf9c1051e50490c4ca99d10202b9049044ea010266124012cdcc1b51eb41a06c49cc5d457cf0d7bf965b6fb949de7b6f2b8fc008388f3c022360a074c72330a80108f8248024fa04487308c44400498c093cc35a41c09324ba979a3efbecb3a27639e53989c1d50292181c4b7afa07015612a90408f8238024fae3476b08c44500498c8b3ce3da40a06c49cc7dfcc5c68dafc9cc99c7671f7b917b19aa0d50dc3970b9a94dd94cee5c90c4e4e69e99074300490c8623bd40206a024862d4c419cf2602654ba29af4dc0b2f90b3cf3e53aaabab65ddbaf5cea5a64a1077df7db09c73ee79b262458b4d6cd8b8c6aa6c26773248627273cfcc8321802406c3915e2010350124316ae28c6713818a24d1a6899733175612cba1c431ba13401275cf10f1e94e0049d43d43c40781c20490442a0302de095424893c02c33be8725b724f62b9a438ae5c024862b9a4380e0285092089540604cc2480249a9937a2d683404592c82330c24f1a92183ee3a48d8024262de3cc3768024862d044e90f02d1104012a3e1cc287612285b127904463405802446c33949a3208949ca36730d830092180655fa8440f80490c4f0193382bd043c49228fc008af2090c4f0d826b5672431a99967de411140128322493f1088960092182d6f46b38b40d992c82330a2493c92180de7248d82242629dbcc350c0248621854e91302e1134012c367cc08f612285b1215021e81117e212089e1334eda084862d232ce7c83268024064d94fe20100d0124311ace8c6227818a24511704e3c68d95698d8df2e2ba75b274e923d9b0a64e3d441a1aa6483a9576dedbd0da2a8b172ff11c368fc0f08c8e861a114012354a06a11849004934326d040d014112290208782760a424ce9e3d4bf6a8db43fef2d7bf6625d115c74d9b373b62e80ae3dab5cff712c94a50218995d0e2585d092089ba6686b84c2180249a9229e284406f024822150101ef042a96c4fb7ff17339ecb0439d11efbbef7e19356aa4ecbbefc7e59c73cf93152b5abc475266cbe9d38f94fdc68c9174bfb4e40ae0cc9933a4aeae4e9a9b9ba5b575a3d35ba1f7ca1cc6390c49ac8416c7ea4a0049d43533c4650a0124d1944c11270490446a00024111a84812d5731277df7db0dc79d7dd72e105e7cb430f3d2c0ffefad772eb2d37c97bef6d95c31b8f082aae82fda8d5c1c993263997992a51ccbddc54ad2eaad7c2858bb26dd5f113274e90e5cb9f7084b2d217925829318ed7910092a8635688c9240248a249d92256087c40809544aa0102de09942d89b9cf49741f81a124f1c2b917c9f5d75d2bc71c73b4cc9b77b92c5ef280f7688ab4acaf1f254d4d4dd2d6d6266bd7aeed754f62eecf72ef4174a5f2e9356ba4a5e5a98ae342122b4646030d0920891a2685908c2280241a952e828540960092483140c03b01632431f7d2d14183062189de734ecb84114012139670a61b3801243170a474088148082089916066104b09942d896afeea7e4475ff61eee5a6eeaae2b3cf3e2b279e744a2898f25704f37737ad7425b1baba5a060ce85f32d64ca64bd2e9b45455953c34b003aa06a464c8a94364e8e8a181f54947c926b0e3e51db23db35ddebea72d72100307d64a474787747777453676e79819d253ff49498d9f1ed9980c643781ccfad552bdfa2ee9f7e673914e348ef327d2093218044226c039143260bab79a803a7faa46ec5ddf53ee2cd5a5a5279f7c62afc39f7c72456882a80652ab88fbd4d7170c714bdb16e73ec44aee494ca552525586f92999cc6432d2d353369e7231f6799c7a4ee2f033872389be49d2814b60ebfaadd2ded52e9b166c8a1c4a6d6dadb4b7b74b7777776463778f3f4152fb4c967e071d15d9980c6437819deb5689b4dc2e559b9f8974a2719c3f914e90c120103201cea19001d3bdd504d4f9539124ea40a3d07312d9dd5487cc10838e04b8dc54c7ac10934904b8dcd4a46c112b043e20c0e5a6540304bc13a8e87253efc304dbb29024f29cc46019d39b3d0490447b72c94ce2218024c6c39d5121e0970092e89720ed934cc01a49544954f72e36344c91742aede474436babe4ee765a69a2d9ddb452621caf23012451c7ac10934904904493b245ac106025911a804010048c94c420265e4e1f486239943846770248a2ee19223edd092089ba6788f8205098002b89540604bc13282a89871e3a556ebde52619366c58c911b66ddb1eea73124b0610c20148620850e93272024862e4c819d0320248a26509653a892180242626d54c340402255712737733bdefbefbe5c2b9178510869e5d22897ae685a82a23802456c68ba321904f0049a4262060260124d1ccbc11b51e044a4a626e988f2f7b54c68cf984f356d88fbdd0010f92a8431688c12f0124d12f41da279d009298f40a60fea61240124dcd1c71eb40a022497403cebf0c75ddbaf57278e3113acc27d01890c44071d2594c0490c498c033ac350490446b52c944124600494c58c2996ea0043c49626e04ae300e1a34987b1203484daa262523e78c94a1a38706d01b5d40400449a40a20e08f0092e88f1fad2110170124312ef28c6b03014f92c84a6278a94712c3639bd49e91c4a4669e79074500490c8a24fd40205a024862b4bc19cd2e02654b62be18724f623885802486c335c9bd228949ce3e730f820092180445fa8040f40490c4e89933a23d044a4aa2bbbbe9ce9d3b65fefc0572ddf537d833fb1233e19ec4c4a4daea89228956a797c9454000498c0032434020040248620850e9323104784e629154238989390fac9e289268757a995c040490c40820330404422080248600952e1343a0e44a6262481498289298e4ecdb337724d19e5c329378082089f170675408f8258024fa2548fb2413401259494c72fd2762ee486222d2cc2443248024860897ae21102201243144b8746d3d01241149b4bec8933e412431e915c0fcfd124012fd12a43d04e2218024c6c39d51ed2080242289765432b3e8930092487140c01f0124d11f3f5a43202e0248625ce419d7060248229268431d338722049044ca0302fe082089fef8d11a0271114012e322cfb83610401291441bea9839208959023d079c28e9d19f92ea099fa72e201008012431108c740281c8092089912367408b08208948a245e5cc540a11602591ba80803f0248a23f7eb486405c0490c4b8c833ae0d04904424d1863a660eac24b292c859101a01243134b4740c8150092089a1e2a573cb09208948a2e525cef45849a40620e08f0092e88f1fad2110170124312ef28c6b0301241149b4a18e99032b89ac247216844600490c0d2d1d432054024862a878e9dc7202482292687989333d5612a90108f8238024fae3476b08c44500498c8b3ce3da40004944126da863e6c04a222b899c05a111401243434bc71008950092182a5e3ab79c009288245a5ee24c8f95446a0002fe082089fef8d11a0271114012e322cfb83610401291441bea9839b092c84a226741680490c4d0d0d2310442258024868a97ce2d2780242289969738d36325911a80803f0248a23f7eb486405c0490c4b8c833ae0d04904424d1863a660eac24b292c859101a01243134b4740c8150092089a1e2a573cb09182589b367cf923deaf67052b275db36696e6e96d6d68dd9144d9d7a8834344c91742aedbcb7a1b555162f5ee23985353535d2d9d929dddddd9efba8b461aa262523e78c94a1a38756da94e3215090002b89140604fc114012fdf1a33504e2228024c6459e716d20608c242a41ecdf7f40560cd5bfd56be1c245ceff8f1b3756a63536caa6cd9b1d31748571eddae765e9d2473ce50a49f4848d469a114012354b08e118470049342e65040c01870092482140c03b0123245109e0e73ef75979f6d9e7a4a5e52967b64a02274e9c20cb973f214a0467ce9c21757575bd56170bbd57092a24b1125a1cab2b012451d7cc1097290490445332459c10e84d0049a42220e09d80119258687a4a12274f9a244faf59e38863feca622191ac1413925829318ed7910092a8635688c9240248a249d92256087c400049a41a20e09d809192585f3f4a9a9a9aa4b3f37de77253f7df6d6d6dbdee41cc17c94a3121899512e3781d0920893a6685984c2280249a942d62850092480d40200802c649a2bb794d577797ac5cb9ca59454412832805fab0950092686b669957540490c4a848330e048225c04a62b03ce92d59048c9344373db91bd3bcf0c20bceca62b92b89d5d5d5326040ff9299ce64ba249d4e4b5555c943033ba06a404a869c3a84dd4d03234a473b5ede21db33dbe5ed7bda2287317060ad747474487777576463778e99213df59f94d4f8e9918dc9407613c8ac5f2dd5abef927e6f3e17e944e3387f229d2083412064029c432103a67bab09a8f3a76ac4def53d26ce32f73ec44aee494ca552525586f92999cc6432d2d3131d1ef5088ce1670e47124d2c484d63deba7eabb477b5cba6059b228fb0b6b656dadbdb237d8c4cf7f81324b5cf64e977d05191cf9701ed24b073dd2a9196dba56af333914e308ef327d2093218044226c039143260bab79a803a7fb497c4beee2dcc15437637b5ba4e999c0f025c6eea031e4d2120225c6e4a1940c04c025c6e6a66de885a0f02465c6eeade73a8903537374b6beb46993efd48e7d988ee7d893c27518f82220afd082089fae58488cc2280249a952fa285804b0049a41620e09d801192a8a6e78ae2e041839cd9e66e5ce34edfbd4f319d4a3b6f6d686dedb5db69a598d8ddb452621caf23012451c7ac10934904904493b245ac10f8800092483540c03b016324d1fb14bdb74412bdb3a3a53e0490447d72412466124012cdcc1b51430049a40620e09d009258841d92e8bdb068a90f0124519f5c10899904904433f346d4104012a90108782780242289deab8796461040128d4813416a4c0049d4383984068122049044ca0302de09208948a2f7eaa1a51104904423d244901a134012354e0ea1410049a40620100a012411490ca5b0e8541f0248a23eb920123309208966e68da821c04a22350001ef04904424d17bf5d0d2080248a2116922488d0920891a2787d020c04a22350081500820894862288545a7fa104012f5c905919849004934336f440d015612a90108782780242289deab8796461040128d4813416a4c0049d438398406015612a9010884420049441243292c3ad5870092a84f2e88c44c0248a29979236a08b092480d40c03b01241149f45e3db43482009268449a0852630248a2c6c9213408b092480d40201402482292184a61d1a93e0490447d72412466124012cdcc1b51438095446a0002de09208948a2f7eaa1a51104904423d244901a134012354e0ea1418095446a0002a110401291c4500a8b4ef5218024ea930b22319300926866de881a02ac24520310f04e00494412bd570f2d8d2080241a912682d4980092a87172080d02ac2452031008850092882486525874aa0f0124519f5c10899904904433f346d4106025911a80807702482292e8bd7a6869040124d1883411a4c60490448d934368106025911a804028049044243194c2a2537d082089fae48248cc2480249a9937a286002b89d40004bc1340129144efd5434b2308208946a48920352680246a9c1c4283002b89d40004422180242289a114169dea430049d427174462260124d1ccbc1135045849a40620e09d009288247aaf1e5a1a41004934224d04a931012451e3e4101a045849a40620100a012411490ca5b0e8541f0248a23eb920123309208966e68da821c04a22350001ef04904424d17bf5d0d2080248a2116922488d0920891a2787d020c04a22350081500820894862288545a7fa104012f5c905919849004934336f440d015612a90108782780242289deab8796461040128d4813416a4c0049d438398406015612a9010884420049441243292c3ad5870092a84f2e88c44c0248a29979236a08b092480d40c03b01241149f45e3db43482009268449a0852630248a2c6c9213408b092480d40201402482292184a61d1a93e0490447d72412466124012cdcc1b51438095446a0002de09182389e3c68d95698d8dd2bf7f7f67b69d9d9df2d8b265b276edf3d9d94f9d7a8834344c91742aedbcb7a1b555162f5ee2994e4d4d8d334e7777b7e73e2a6d98aa49c9c8392365e8e8a19536e5780814248024521810f0470049f4c78fd610888b0092181779c6b581801192e80ae2a6cd9bb3d23773e60c193e6c585614f38f71855149e4d2a58f78ca1592e8091b8d342380246a9610c2318e0092685cca0818020e01249142808077024648e2f4e947ca7e63c6f45a3974a5f0c575eb1c0954d258575727cdcdcdd2dabad12152e8bd4a50218995d0e2585d092089ba6686b84c2180249a9229e284406f024822150101ef048c90c442d3cb97c4d9b36739872d5cb8287bb85a4d9c3871822c5ffe44afcb52cbc58524964b8ae374268024ea9c1d6233810092684296881102bb124012a90a08782760ac24aad545258a2b57ae92d75e7b4d9a9a9aa4adadadd73d884a12274f9a244faf59232d2d4f554c0949ac18190d342480246a981442328a00926854ba08160259024822c50001ef048c9444f77ec3d75e7bdd91c2fafa5148a2f71aa0a5e5049044cb13ccf442278024868e980120100a01243114ac749a1002c649a22b88efbcf34ef6d2d24a25b1baba5a060cf8c72ea9c55e994c97a4d369a9aa2a7564703faf1a909221a70e6177d3e09026bea71d2fef90ed99edf2f63d6d91b31838b0563a3a3aa4bbbb2bb2b13bc7cc909efa4f4a6afcf4c8c66420bb0964d6af96ead57749bf379f8b74a2719c3f914e90c120103201cea19001d3bdd504d4f9533562effa1e1366594810ddb82bb92731954a495519e6a7643293c9484f4f7478d42330869f391c4934a1200d8971ebfaadd2ded52e9b166c8a3ce2dada5a696f6f8ff43132dde34f90d43e93a5df4147453e5f06b493c0ce75ab445a6e97aacdcf443ac138ce9f4827c86010089900e750c880e9de6a02eafc314212f32f31cdcf0abb9b5a5da74cce07012e37f5018fa61050cfe55db7527a56dc26f2c69a487970a95ca4b819cc42029c43162695294546c088cb4d0b3d27319f10cf498cac6618c8300248a26109235ced082089daa584802050160124b12c4c1c048182048c9044b54ab84f7d7dc1096c686dcdee68eaae36a65369e7d8dc9f79c93fbb9b7aa1461bdd082089ba6584784c2380249a9631e285c03f082089540204bc13304212bd4fcf5f4b24d11f3f5aeb410049d4230f44612e0124d1dcdc1179b2092089c9ce3fb3f74700492cc20f49f4575cb4d6830092a8471e88c25c0248a2b9b923f264134012939d7f66ef8f00928824faab205a6b4f0049d43e4504a839012451f304111e04fa208024521a10f04e00494412bd570f2d8d2080241a912682d4980092a87172080d0245082089940704bc1340129144efd5434b2308208946a48920352680246a9c1c42830092480d40201402482292184a61d1a93e0490447d72412466124012cdcc1b51438095446a0002de09208948a2f7eaa1a51104904423d244901a134012354e0ea1418095446a0002a110401291c4500a8b4ef5218024ea930b22319300926866de881a02ac24520310f04e00494412bd570f2d8d2080241a912682d4980092a87172080d02ac2452031008850092882486525874aa0f0124519f5c10899904904433f346d4106025911a80807702482292e8bd7a6869040124d1883411a4c60490448d934368106025911a804028049044243194c2a2537d082089fae48248cc2480249a9937a286002b89d40004bc1340129144efd5434b2308208946a48920352680246a9c1c4283002b89d40004422180242289a114169dea430049d427174462260124d1ccbc1135045849a40620e09d009288247aaf1e5a1a41004934224d04a931012451e3e4101a045849a40620100a012411490ca5b0e8541f0248a23eb920123309208966e68da821c04a22350001ef04904424d17bf5d0d2080248a2116922488d0920891a2787d020c04a22350081500820894862288545a7fa104012f5c905919849004934336f440d015612a90108782780242289deab8796461040128d4813416a4c0049d438398406015612a9010884420049441243292c3ad5870092a84f2e88c44c0248a29979236a08b092480d40c03b01241149f45e3db43482009268449a0852630248a2c6c9213408b092480d40201402482292184a61d1a93e0490447d72412466124012cdcc1b51438095446a0002de09208948a2f7eaa1a51104904423d244901a134012354e0ea1418095446a0002a110401291c4500a8b4ef5218024ea930b22319300926866de881a02ac24520310f04e00494412bd570f2d8d2080241a912682d4980092a87172080d02ac2452031008850092882486525874aa0f0124519f5c10899904904433f346d4106025911a80807702464ae2cc99334405be70e1a25e339f3af51069689822e954da797f436bab2c5ebcc4339d9a9a1ae9ecec94eeee6ecf7d54da30559392917346cad0d1432b6dcaf11028480049a43020e08f0092e88f1fad2110170124312ef28c6b0301e3245109e23ef5f5b2a56d4b2f491c376eac4c6b6c944d9b373b62e80ae3dab5cfcbd2a58f78ca1592e8091b8d342380246a9610c2318e0092685cca0818020e0124914280807702c648627dfd28696a6a9281037793ae4c976cddb6b597242a79acabab93e6e666696ddde81029f45e25a890c44a6871acae0490445d33435ca61040124dc9147142a0370124918a80807702c648e2f4e947cae8d1a31d096c6c3cdc9971eee5a6b367cfdae53db59a3871e20459befc09512b8a95be90c44a8971bc8e0490441db3424c261140124dca16b142e003024822d50001ef048c91c4dc29e60ba1bbcad8d6d6d6eb1e4425899385a8ea3b0000200049444154274d92a7d7ac919696a72aa68424568c8c061a124012354c0a2119450049342a5d040b812c01249162808077024862117648a2f7c2a2a53e0490447d72412466124012cdcc1b51430049a40620e09d402225b1baba5a060ce85f925a26d325e9745aaaaa4a1e1ad80155035232e4d421ec6e1a18513adaf1f20ed99ed92e6fdfd316398c81036ba5a3a343babbbb221bbb73cc0ce9a9ffa4a4c64f8f6c4c06b29b4066fd6aa95e7d97f47bf3b948271ac7f913e904190c022113e01c0a1930dd5b4d409d3f5523f6aeef31699685ee3face49ec4542a255565989f92c94c26233d3dd1e1518fc0187ee67024d1a482d43cd6adebb74a7b57bb6c5ab029f2486b6b6ba5bdbd3dd2c7c8748f3f4152fb4c967e071d15f97c19d04e023bd7ad1269b95daa363f13e904e3387f229d2083412064029c432103a67bab09a8f3c70a49647753abeb94c9f920c0e5a63ee0d1140222c2e5a6940104cc24c0e5a666e68da8f52060c5e5a60a25cf49d4a3a088423f0248a27e392122b308208966e58b6821e0124012a905087827608d242a046a37d3868629924ea51d221b5a5b7bed765a292636aea99418c7eb480049d4312bc464120124d1a46c112b043e208024520d10f04ec04849f43eddca5a228995f1e2683d0920897ae685a8cc2180249a932b2285402e0124917a808077024862117648a2f7c2a2a53e0490447d72412466124012cdcc1b51430049a40620e09d009288247aaf1e5a1a41004934224d04a931012451e3e4101a048a104012290f08782780242289deab8796461040128d4813416a4c0049d4383984060124911a804028049044243194c2a2537d082089fae48248cc2480249a9937a286002b89d40004bc1340129144efd5434b2308208946a48920352680246a9c1c4283002b89d40004422180242289a114169dea430049d427174462260124d1ccbc1135045849a40620e09d009288247aaf1e5a1a41004934224d04a931012451e3e4101a045849a40620100a012411490ca5b0e8541f0248a23eb920123309208966e68da821c04a22350001ef04904424d17bf5d0d2080248a2116922488d0920891a2787d020c04a22350081500820894862288545a7fa104012f5c905919849004934336f440d015612a90108782780242289deab8796461040128d4813416a4c0049d438398406015612a9010884420049441243292c3ad5870092a84f2e88c44c0248a29979236a08b092480d40c03b01241149f45e3db43482009268449a0852630248a2c6c9213408b092480d40201402482292184a61d1a93e0490447d724124661248b224ee565525435355322495323379441d0b81ed3d3db2b9bb5bb677f7c432be3b282b89b1e26770c309208948a2e1254cf8a5082089a508f1730814279054493cbd76373976e06eb2ad5f3fd9dad54d9940a06c02ea8f0b437abae50fed1d72fdd6ed9229bb65b0072289c1f2a4b76411401291c464557c02678b242630e94c3950024994c4eb3e344826eeb9a78cdb638f4059d259b208bcfceebbf2f7bfff5d666e7947e25853441293556fcc365802482292186c45d19b76049044ed5242408611489a241ed6bf5a2e1f314c0efcc8470ccb14e1ea48e02f6f6d91bbded8240fb677441e1e9218397206b488009288245a54ce4ca510012491ba80803f024993c42b3e3448268d18211376dfdd1f385a4340445eede89057366e947f6d7b37721e4862e4c819d0220248229268513933152451a4e78013253dfa53523de1f31404040221903449fcefa143a4ffb0e1b27fedc040f8d149b209bc9dc9c8eb1b36c817b6bc23eff7447bd1299298ecda63f6fe08208948a2bf0aa2b5f6045849d43e4504a83981a449e2ef870e917e48a2e655694e78ae241ebbe51de94012cd491c91269e0092882426fe24b01d0092687b86995fd80490c4b009d3bfcd0490449bb3cbdc6c268024228936d73773131124913280803f0248a23f7eb44e3681244be298744a8ea8ae96c6ea74b28b80d9574ce099ae6e59b533238fedcc4857c5ad836980242289c15412bd684b0049d436350466080124d1904411a69604922889e9aa2af9fa806a9931b846fe3e202dfd52555ae686a03426d023d2b9b34bdedeb653bebbbd5dde8ef8526d4506494412353e43082d080248621014e923c90490c424679fb9fb259044493ca67f3f397fe860d97bf7017ef1d13ee1045adfcfc88b6f6e9373b777482662164822921871c9315cd40490c4a889339e6d049044db32ca7ca224903449ec27228b060f94b1c306496d3a15256ac6b294c0936f6d973bded921ab33d15e786a95244e9d7a8834344c9174ea1fd77e6f686d95c58b97782e999a9a1ae9ecec94eeee6ecf7d54da30559392917346cad0d1432b6dcaf11028480049a43020e08f0092e88f1fad934d206992b867aa4aae183c500e1f3e38d98967f6811158f94ebbfcb66d87fcb27367607d96d3913592386edc5899d6d8289b366f76c4d015c6b56b9f97a54b1f2987c52ec720899eb0d148330248a26609211ce3082089c6a58c803522903449dc379592b307d7c8bf0cdf5da32c108ac904fef84ebb2851bcaba333d2695823893367ce90baba3a696e6e96d6d68d0ec442ef55421749ac8416c7ea4a0049d43533c4650a0124d1944c11a78e0490441db3424c261140127d666bf6ec594e0f0b172ecaf6a45613274e9c20cb973f216a45b1d217925829318ed7910092a8635688c9240248a249d92256dd082089ba6584784c238024fac8587dfd28696a6a92b6b6b65ef7202a499c3c69923cbd668db4b43c55f1084862c5c868a021012451c3a4109251049044a3d245b09a114012354b08e118470049f4913224d1073c9a5a4f0049b43ec54c3064024862c880e9de6a0248a2d5e96572111040127d40b64a12fb57c9870e1b2203d2d53e88d014021f10480d4acbf6b776c8bb7f7c27722ceaa6e7f6f60ee9ea8a70dbe68f364ad5c8032595d91ef97c19d04e023db57b4bf733f7896c5917e90463397f44e48cdadde4c08f7c44d6b677443a5f06b393c0a7060f923fbffebafc7447877446fc40f038cea1bd535532b3a6bf4c195aeb24f40fdbdeb733b1cc2a12029f193440d66fef94355bdf9787d8ddd41bf34aee49acaeae960103fa971ce8edb7df968103074a3aad9e7ac30b0210800004200001084000021080403208548dd8bbbec7f4a956b2bb692a9592aaaaaa9253aeaeee273b7766a427e2bf7c950c8c0320600881dd76db4dde7ffffd489f356a081ac2844049029c3f25117100048a12e01ca24020e09d803a7fac90c4309e9318c7650ade53494b08e847807348bf9c10913904387fccc91591ea49807348cfbc10951904ac794ea2c2ad76336d689822e954daa1bfa1b5b5d76ea795a6845f2e9512e37808f426c039444540c03b01ce1fefec680901458073883a808077025649a2770c855bf2cb2568a2f49734029c4349cb38f30d9200e74f9034e92b89043887929875e61c140124b108497eb9045566f49354029c4349cd3cf30e8200e74f1014e923c9043887929c7de6ee9700928824faad21da43a04f027c40531c10f04e80f3c73b3b5a424011e01ca20e20e09d009288247aaf1e5a42a004013ea02911087827c0f9e39d1d2d218024520310f04700494412fd5510ad21c039440d4020140248622858e9344104388712946ca61a380124912fb88117151d42c025c00734b50001ef04387fbcb3a325045849a40620e08f009258845f3a9d761e02ded3d3e38f32ad219050029c43094d3cd30e8400e74f2018e924c1043887129c7ca6ee9b803a7faa46ec5d8f05f9464907108000042000010840000210800004ec208024da91476601010840000210800004200001084020100248622018e9040210800004200001084000021080801d0490443bf2c82c200001084000021080000420000108044200490c04239d400002108000042000010840000210b083009268471ecb9ac5cc9933649ffafa3e8ffdcb5fff2a4b973e52565f951e347bf62ca7c9c2858b44c551575727cdcdcdd2dabab15757f5f5a3a4a9a949060f1ab4cb101b5a5b65f1e225150d5deeb815751ae0c1e3c68d95698d8df2e2ba75a1b10f305cbaca2150a856b76edbd6abaea74f3f52548e57ae5c252d2d4fedc2cfed43fd20f77c50ed0e3ce0805ec7173b3f9376de2830b9e73685691601f7f75efffefd0b069e7f1e0539bbdccf9f912347cae44993e4e9356b0a9e9f7d7d666e69dbe27c9699fee21c323d8395c55fea73c5fd1ce9ec7cbfcffa76fbc8fd3c2ae7b3303fd242b1b8c7747676ca63cb96c9dab5cf179d60fef7a762df2dcb21c5f7b15d292189e5548e25c7f83d8182c2508e24b6b5b5f51242f7e4ddba6d6b451fceba7f08f24b29a8aa8ab61f376f9b366fee55a7aade060f1a9cfd80732571c78e7679f2c92777f9d053e7c25e7bed29994c575612d57bc387fdfff6ce3c4e8ae2ece30fb0dccb728acb82880a08a811afc58308fa2a1a15410ef1081ae3110151b92f0fe43ec50b2189c7abc403056f4d0c081a15c424721801f15a0411168802cbb5bb2ceffb543e35e9eded99ee999d656667bff317ccf654577dabaaab7efd1c95596c913cf7dc73243bfb2cd9bcf907cf17257691ae28f306917864c77bbcef962ccf3d9d577e22d1fd4233d6b528de0ce3515eb2af8ff1682365fc87409075c5ae236969552437777b89b546c77ec78e1da556ad9a662d53a342d0b5d04b249ed8ba75203118b40f4bbbc74d96e752d0f61e89eb108947827292dca3b413285ecd884524eabded46d93e9c82d427d917411e4a417a31f9ae51f1e7b5c0b9fbd35ef7d3cf3f4b6e6e6e316bb12ec8175e78811188b56ad53222513f6a49778b3dbbc8fb59e0bd7e978af30691987c73229a1a25cb732f1691e83717a3e190e86b937d7d4c349f54b97fb89788eeb16cd79f7dfbf6890ac5254b9616f3f6d2f5ac71e3c652bf5ebd90f753d0b51091583e471322b17cf65b4cb50e2a1275e148ab922695ab5409b97daaabe7962d5b8c35a34ae52a72a8e85031173a2fd701a77b6850b7cf480f33af8da1dbcdc1eda6e075df35abd7c82f4efd45898db8fb61e76e93b33dbab968dffe54d9bd7b8f1cddb8b158f728fb90b5eeb2eefab8ddacb6e5e6167be0c6d4b1fce88813f07323b515b2634add899b1f738cfc75d1a2d0a2ab7fcbca6a2279797b43eed776fc4472f7f16a6cb4f3c6cea5860d1a9ae2dcf339dc7c5551ab1fa7ab9d7ba36d45a93e27f4e374cd8b75deb8ebabf3ade8d021293c54189567c1111f28dcd09340509168c7d68e9d3b24ab499629cb3e53752db2e3d739c6bc5cdf9ccfe168dd4dbd5ecc78ada57eeb85db62e99c373ffffcb3093bd8b479b31cd3ac9958375c778885dbfdd5f977bfb5903954712763103752a5e35c47d2d36bcb962d3f865e6ceadfba5c7cb17cbf699379416a436482ae85b18ac4487b4b3f7753bf39c17ecc7f4e2012fd19a5cc15d188445d7cadcfb99da4ce3811dd4456ab56dd583fbce23af45ecd9a350d09c9788944671bd2d3d3cdc2ea74f973bb5484bb6f76767609973ef7b54e973fb74b85dd08ebe26e37cc5e6e17cefae4e5e5192b911500ce075859c683a6cc004ea286b8179f70314a56242e5bbe5c4e6bdf5ed6ae5b178a7dd2f1a68b70464646b1185de7a2e8166fe110f88944e7bcf112a2ee853edcbc69d3a64d89184b67d9eebfbb3727b1cc1bf51c70cf6bbb594e95d8b0241ada47a42ad188441583eaaeedb4b4eb4b38fbcc745bcaddd631b77b686945a296d7b9732759b56a75682ebbd73bb77bb897c5d24b242a7c1b8be59e93e1eea1f363f3e6cdbe6b2173e8880ceda4bd499075c5b98eecdebddbbcc4b4fb1b1dafeddab69595ab56c9b9e79c13128941d7c25844a2d7bc71ce03fb72c50ad668f687ecc7820d554462304e297155a4c435e104a02696f15ad0fd04a77b72978548d40d698b162d8a25fc706f96c3ddd70a4cfb7071b671fdfaf546cce5e4e414730f745a1aebd5ab67acaa4ed757fd7ba4fae843d7eda2188b2b604a0cc61469849f05dd3966dab56b675aadc9976c6c87c629eaf76e6b859f35c48d2f1a91a82f75d40afefefb1f148b9174ce9570f3c60a4cebd6ea35dfd432ea4c30e57c16e8efa39d376bd7ae2d91dc29e89bf114196629d70cbfc435e104a08270af3d410467b8f11c6be21aad87ad63b8b9e72746bd44a2f385a7d79ae4e54eae75f15b7b9843293785626a90dfbae21ccb3a6634fed0c6d2eb78d68fd758b263d09d6c2d52b2c170896bfc5e8c7acd1b2f91e8b73f643f166c08211283714a89abfc849d6d64b837b1ce0c9c5e65b9177ee7642f0b91a8d6c070d95aedc329d27d9d7f736ee695835a28bd32ef59b72515896ef7a148225ceba39f704910c86e5afea7989765d8fd6241dfc4aacba92e60f62d6d9079e965cd77128b4624eabddd8bb92dcb5ae622cd9b709b5fb56684cb4c6c9f057a9f68e78dbab97b2517219eaafcce9920c24e5b17ce92e07c8e862bcbfd3cb663db4fbc39a9869b9b3af6740dd0acc56e6b86fdbd75add697315eeb45a4cdae96e16c97b514865b27fcd61ee650f99d2b655973f7bae27e0968bd5df4c5b9ba9aaa274cb8f1eeb51e392dfeee76848b65f46a6fb8bd65244ba2dffe90fd58b09185480cc62925ae0ab219d586462b12f56dac8d55b4e2acac2c895a376ba970babcba8fd2f012bceef63b1f525a7f5b6e10eb9ed7e6c5af3e918435223125a65828a6c3ba143bc798bab7d885b675eb56a1788fa0f33252ec879f4874ce1bb7db9917f94822d139f6b3b2b2446357d425295c963b67f9b1cc9b70c9451089e577ce94a548d471a1e112ce38c4d25812bd6212830838f70ba2203189ce7520c83d9ceb9c0dfff05a0b9943e577ae9475cd9deb8a7dd1672dd6366e7ec386af8caba9bee0747b6185ab9f9fb7471091e88c6ff7da5b4612891a3f1f694eb01f0b36b21089c138a5c4554137a3d18a447d63e35e4883c638853b27315c9646e7425bdacdae5d84352942a3868d426765c5bad9f5ab8fd7433188204d89c197428df05bfcc259a86d6c5d8d1a354c3653a71b8f9d3f5e317f4ecb44b874fd9144a27b831824d140249168efa519f09c59eefcb844b20cb98ffc700e172f4111e45e2934e452ae29652512bd2c6eeeb1120f4b62105750bffb38e7a1977526c83decc0f05b7b9843293785a26a50a467be737d708b441b16a1cffa03070e844225ecd9ce3634275ca2b5482ff2828844af3d6ba479e3bcde2bef84131afbb160430891188c534a5c559622d1b9c9b3c247a1d943c44beb6eea4e3ea0657b7d1729898157fbad9b8efbf066fdde9978c75a582325ebf1ab8ffb814ae29af23badac9b8e3be6c24b9039e350edef9c09579ce35289a8cb66f56ad54a9c1f1569c10d2712bdc6a4bd56efa5c9409c71c73626ca6fbeda76b8b3f7daef9d89989c1b582fb73bbf79a36771b937c176de92b8a67ccea1b21689ced83e6b598ca7bba97b2d71af17eec435ee316ee7a09e3717ce65d5cdc83d07dcf163ba71779e23ec5e0b9943e573aec4a3d676acf8ad2bee75c43d4e972d5b5e224745d0b5d0dd8ea02231d2de3248e29a707382fd58b09185480cc62925ae8a14b7a00df48ae3738ab14831897621d6eb35fe48ad26ba390ebae9b480bd02abeddfbc82a0bd12203837a87e9b5df762eeec68372fa7900ce7bee3571f77fb3802a3fc4e2dafbef6124d4e91e8b5398ef4f2c2492752128068e78dd7f5d11c59e325ec6c5ddd09099c4c629d375ab6733e720446f99d37ce35c52bee5bffee17fb1d2926d1e9a2a665a938d45002bbd974268a8a35718dfba5a2dec73deebd5e20398f90cac9d9688ebbf8e7679f79c679857b5638e3f09df7f05b7b9843e57bcec4a3f65e7b40af63549c9e5ceef5c96b5c06590b631189f6e5bcf3a826e7ded29d44275c5d9dcf19e7fe90fd98ffa84224fa33e20a08400002108000042000010840000215860022b1c274350d850004200001084000021080000420e04f0091e8cf882b20000108400002108000042000010854180288c40ad3d534140210800004200001084000021080803f0144a23f23ae80000420000108400002108000042050610820122b4c57d350084000021080000420000108400002fe041089fe8cb80202108000042000010840000210804085218048ac305d4d43210001084000021080000420000108f8134024fa33e20a08400002108000042000010840000215860022b1c274350d850004200001084000021080000420e04f0091e8cf882b20000108400002108000042000010854180288c40ad3d534140210800004200001084000021080803f0144a23f23ae80000420000108400002108000042050610820122b4c57d350084000021080000420000108400002fe041089fe8cb80202108000042000010840000210804085218048ac305d4d43210001084000021080000420000108f8134024fa33e20a084000021080802f81f3ce3b571e79789664666686aeddba75abdc79d720f9f8e365a1ef860e192c393939b260e12bbe65ea055a6e972e17cbfdf73f10e87a2e8200042000010894960022b1b404f93d0420000108547802bd7af690891327c8aa55aba4cf35d785782c5db258b2b2b264cc987b8c289c317d9a74ed7a45e8ff7ee0acf0fcfaeb6f8a95ebf73bfe0e010840000210280d01446269e8f15b084000021080804858f167c5e39b6fbe2543870d4724325a2000010840a05c104024968b6ea292108000042090cc04d442d8ab570f993d7b8e4c9f31d3b3aa7acdb5d7f609fded8517e68784a3f37bbde0a38f3e96471e7dac98fbaa755d9d307e9c29e3820b2f0a95a5164bfb9ddbedb5a0a02062bd92992b75830004200081c410402426863b778500042000811422e016661b367c554cc4d9a6badd4d870d1d22b7dc72b33cf1c493217139ffc5e7a543876c23ec962d5f6e84a2d3ddd429086db9ceefdc7fd7f25ab63ca1446c640ae1a729108000042010670288c43803a5380840000210a8b804dcd64225a156411ba7182426d1291ca31589f7dc7b9f1195bb77eff114a915b7676839042000010844430091180d2dae850004200001080424e0b42e3a5d4bbd12d7d8d8c5f4f4daa674eb221aad48541754a750c5d53460677119042000010814238048644040000210800004ca8880158ad6b2e7e56e3a60403fa95ab56ac8e2581a4ba2334ed12952118b65d4c1140b010840204509201253b463691604200001081c19026e21e8beab3346d02d12bde2059d4970825812fdeecf311a47661c701708400002a9440091984abd495b2000010840202104ac8ba733fe502be24e4ce3febf8ac4f6eddb87ce4dd4bfab65513f3653aa57221a9bd84633a9da7b6bb21caf9844afe4380981c44d2100010840a0dc104024969baea2a2108000042090cc04dc71855ad7bcbcbd2101a8ff77ba805a41a922b075eb56a669ea16ba60c12ba2718bab56ad32096fac087496e5fc8d8a43fb517753af7ad898c864e647dd2000010840207908201293a72fa8090420000108400002108000042000818413402426bc0ba800042000010840000210800004200081e42180484c9ebea026108000042000010840000210800004124e009198f02ea002108000042000010840000210800004928700223179fa829a4000021080000420000108400002104838014462c2bb800a400002108000042000010840000210481e0288c4e4e90b6a02010840000210800004200001084020e104108909ef022a000108400002108000042000010840207908201293a72fa8090420000108400002108000042000818413402426bc0ba800042000010840000210800004200081e42180484c9ebea026108000042000010840000210800004124e009198f02ea002108000042000010840000210800004928700223179fa829a4000021080000420000108400002104838014462c2bb800a400002108000042000010840000210481e0288c4e4e90b6a02010840000210800004200001084020e104108909ef022a000108400002108000042000010840207908201293a72fa8090420000108400002108000042000818413402426bc0ba800042000010840000210800004200081e42180484c9ebea026108000042000010840000210800004124e009198f02ea002108000042000010840000210800004928700223179fa829a4000021080000420000108400002104838014462c2bb800a400002108000042000010840000210481e0288c4e4e90b6a02010840000210800004200001084020e104108909ef022a00010854540295d22a49ad136b49f5acea929651550ee71f9283dbf3e5c07707247f5b7ea9b13469d244468e18269d3a7592060dea4b952a55243f3f5fbefdf65b79e2c9a7e48517e697fa1e8928a057cf1e3271e204d9b2658b5c70e145655e85f3ce3b571e79789664666696b8d7a1438764f7eeddf2de7b4b64cc3df74a5edede52d7e7c20b3acb7df7dd2bc71f7f9ce9b3e5cb3f915ebdfb94ba5c0a80000420000108042580480c4a8aeb20000108c491409d3332a45ec7ba5239ad92a4d5ac2669d52acbe12291fcbd0552547448f67fb35f7e5afa9314ee2a8ce9ae975cd245c68f7b40b2b29ac8b66ddb64e5aad572e0c0016973626b69d5aa95a8b8f9fd1ffe2853a74e8fa9fc44fe285122b151a3469293b3510a0afe2be0ab57af2ec71c738ca4a5a5c91b6fbc29fd070c2c359a8766cd945ebd7aca86afbe92cf3fff977cf9e597f2f8e3734b5d2e0540000210800004821240240625c57510800004e244a0419786927e726d496f942e35326a9428b5f060a1e4e5e649c1be02d9b62057f27f3c18d59d5bb76e2573e73e2e2d4f38415e7fe34d19356a74310bd71d03facbc08177486161818c1e73afbcfefa1b51955fd12eb696c4f4f43a3266cc3db260e12bc510dcfcdb9b64e4c8e1b277ef3e193c78882c59fa7ea910cd7ff179e9d0215b66cf9e23d367cc2c5559fc18021080000420100b0144622cd4f80d042000811809a8f5b06e877a9291952155ab578d584ade8e3db22f77bffcf0c416399c5f14f88ea3478f94dfdd76abac5fffa5f4ecd5dbd305f299ff7d4a3a74e8204f3df5b44c9b3e43ce39e76c193d6aa4b46ddb466ad6ac29870f1f36bf5bb478714864ce983e4d7af5ea212f2f5828e79cdd415ab46821454545f2af2fbe902953a649d7ae5748b72bbb4aeddab565d7ae5df2d2cb0b64ecd871a6de2a7cdab76f2f2fce9f2f575ed9558e6ad4c8b8be7efae9dfcdfd3ffb6ca5b94e05ee3d63464b7676b6a4a7d7964a952ac9fefdfbcd75631f18271b367c255e96c49e3dae92fe03fa49ab962da572e5ca92939323cb3f5921bd7bf594050b5e91a1c38617ab43d72b2e97c68d1b9bfa6fdcb8510e6ff6c500000db8494441541e7ae81159f8caab9e8cfd44a2d6f3edb7de34eea856449e7efa69327cd850c9ce3e4bd4da78f0e041f9e28bb53269f214e33eea64b262c50a39fffc5f9a7a171414488d1aff7d71a07da065fee5dd7765e890c1d2ad7b37c34e3fdb77ec905716be2ae3274c34ffb75c366cd8206af56cd6aca9e4e6e6ca575f7d2d679fdd21a67e8ba63f3effd7e7927f30dfdc4bdbbc77ef5e79f7af8b8abda4b0e3eca493da85e5d2b95327193e62a89cd4ae9db1d06a399f7cb242264c9c64fa9f0f0420000108943d014462d933e60e108000040c816a8daa4ae68d4da44ee33a52bd76f54054fe9df36fd9f5cf5dc6f534e8e7f5d75e91f6ed4f95279f7c5ac68d9fe0fb3315024f3df947e336b96edd7af972c306c96ad2c494a19bfd79f39e33f1762a12fbf4e96d84ccce9d3b65e5ca55d2a64d1b133ba762242323c388b94345457276876c2334274e9a22cf3cf3ac11682a10d4cdf5c7ad5b65f5aad572d2492799dfea3d7f777b7fc9cddd267f9af7ac9c79e619f2f5d7df18f159273d5dce3aeb4c53f6e2c5efc96f6ebab98448d418be69d3a6c851471d65cadafcc30fd221fb2c494f4f372263fefc97432251eb50585828df7fbf49d6ad5b276ddbb695962d4f906fbffdce94adf19aee8f9f48544138e7f1d952b76e868c1a354672b76f979933a64b932699219e27b66e6d04f8f6eddb65f8f091c6daa84cb46c15cb2a82aad7a82e878b0e9b76b46871acf92e67e346993fff25b9f186be72d555dd65cf9e3d46fc6abf649f7596d4ac59435e7df535b9ebeec1212eb56ad5941f7ed8226bd6ac317da06ec63d7a5c1575bf2d5cb830aafe484bab22050585f2f77ffcc320d4fad5a851ddb8354f9a34456c3fa998d6fe75f2b763203bfb4cf392a056ad5af2d9ca95b275eb3639f9a4934c1fad5fbfdeb8f322147da73417400002102835014462a9115200042000816004ea77ae27f5b2eb4bfde6f583fd40440ee61d943db97be4fb8737891c3aecfb3b6bd5528172dffd63e5c5175ff2fdcd80fefd64e0c001b27af51ae973cd75a1ebad4552c58a7eaf22f1da6bfb181179fbedfdcd66fde28b2f32dfab409afbfb3f188ba27ee63cfe98b12c3ef7fc0b3262c42823883a763ccf0803bbd1d7baaa283cedb4f64648ac59f3b98c1fff80ecdcb1436efb5dff9060bbf1c61b64cce89146f868a21ab725f1d9679e96ce9d3b85c492dedf0a124ddea3097aac2551ebf0f1c7cbe4b737df622ca55a8737de784d9a6635f57425d5b2228944bdcf9d770e34c25663076fbdad9f0c197cb75c7ef96532ef4fcfc9bdf7de1fe279ff7df7c84d37fd46de7efb1d1970c79d21266fbff367b9edb6db43d7b9dd4dafeade4d264e1c6fc4ded0a1c343eeacca77c2f8714608aa9b6b83060d4c429f83070f18b1aae5ea27d67efbf0c38fa2ea8fc3878b64d2e4a9f2ecb3f3cc7d870d1d220306f493152b3e35e367f6638f182bb2b6fff67e03cc35760ce88b8a993367196ea79c72b23c38eb219933e7f7212673e7cc964b2fbd44fef0c7278ce0e4030108400002654b009158b67c291d021080408840d35bb224e3b8ba52b36ecdc0540e1f16d999b3437217e6ca819c03bebff3b37af916e0b8c08a31b5e074ebde2324365e7e7981dc3d6888b9d2de4f5d25d59af5b7bf7d68be1f317ca8f4eb777b31574faf383b2b24962d5b2ed75ddfd7b37af61e2a92fade70939c7e5afb5076d341838698f84b75915521b868d1e250199a00a677ef5ec544a2d661ce9cb93275da8cb0a2cc5d8948d94dedb53b76ec94c953a6c85b6fbd6d5c4f55a47ff0b70f65dfbe7da1e2d26bd7960b2ee82c1b377e6fc46eb8d843f7f713278c971b6ef8b529bb5fff3b8a554f0572a74ee71babf1dab56b3db3be5a91184bbf797548b8fed8ba75ab5c7e45d7907bb35bccbfb7f85d69dab4997979f1d24b2f97285a5d6e1f7ee84163fdd5715478e850e89acca38f366eacf6854534e3986b2100010840207a0288c4e899f10b084000023111687e7773c9689a21d56a568beaf7fffe6ea7ec58b453f2d6e405faddd2258ba569d3acc096445b68fb534f955ffeb2a3b46bd7565ab56a29cd9b3737f1856a31545163c586b5cc3945a2fefbcebb06192b9d7eacf873c703ba13bf78c517aa55a9d3f9e7cbc9a79c6cdc0c8f6bd1c2b89b6a9656bd4793cccc9018ba7fec034658ecdebda798400957072fa1ea9728c68a22afeca67bf6e49918c3d75e7fdd700a22287ffcf14763491c3ce86ecf0435eefa28f7debd7b7aba0f3bfbe4934f3e89281263e937e5184d7f388f2471f6edc851a38d2551634c9de3c439a0edf56a5d0cf7d11716ff73d12581e60117410002108040ec041089b1b3e39710800004a22270a444a28a0cb5ba448a49bcefde7be4baebae910f3ffa58a64f9f6162e8d4ed5337f11a2397979767e2c14e38e1f890e5ab2c45e2e6cd9b8cb572f6638f1ad751b52669eca0262dd1f3109b356b66feed16899a0846ebf5f3cf3f97b9480c97ddd43908ac48748b66af8112d49298289138f68107a2ee8f7022f19e7bef33674d46e272a48f36896af27231042000810a46009158c13a9ce642000289231093bba988ecfc2eb8bba9b6ce2fbba98d033be38cd3e5b9e79e3740aebffe3a938866f294a9a1ec9b37dd74a3c978ba79f30f71b1246adcdecc0767153bf3cf5a1c972e7ddf64381d34e82e230a274e9c2c7ffecbbba66e36ee518fec708bc448eea62a7c35d18ec665da98c4d258128388c4e38f3f5ee63dfbb4c99caa02f6e9a79f093be0828a443f775375d35417da6fbef936ae9644cdfa1a6d7f841389fa7d3877d3a953279b38534de6a3c96ef4e3761d4edcace5ce108000042a26014462c5ec775a0d01082480c091485ca3cdb2d94ad55dd4eb9c44151d9a804633946a6ce19d03ef306e8fce583d15920f3e38532efbd5a5e6088578b89bba93c6685299a79f7ac2d477d6ac87e5d8638f35f572c6ce697b3499cd0d7d7f2d3b76ec282112b55e5e896b2c83e38e3bae444ca2fbfcc1a0eea64144a2d657dd2abb75bb5234ced226c8d1eff52cc5db6ebdc52408baaa47afc031897e896baa54a92cc3868d30aec19ab84645b653acc56a01d63ac7d21f766ab92d835e896bec999e594dfee31e7d4d9fab4d36dbd75e7f43060ebc2b344b1f7df461b9b2eb1526e98d263ee2030108400002654b009158b67c291d021080408840cc47607cb64b7e5a12fc080cbde135d75c2da3468e94860d1b9858be95ab564b417ebec91ca9e71bea510a9a8972debc3f898ac6be7daf37495654d8e8997ea79f7eba64661e6dceeed3e30ae225123513a73dfee0d4ff3fa6e39866cd4c1ce32db7de26bfb9f14663b95297574d50f2ef9f7e3267e5e93119fa9d1e1fe1b6246abd7e75e9253269d20493dd538f52f8eebbefe4dc73cf95060dea9bfa3bb39b96b52551d93b8f7af87ed32663213db67973d1b30195ade51ed492a8656adc65d02330e22512f5acc958fa239c48b45cd4caba76ed3af9fa9b6f448f0fd131a09954357151dfbebf96d1a346489d3a754cb6d875ebbf943627b69656ad5a153b3e84c70a0420000108942d014462d9f2a57408400002c508d4ed5857ea75a827194d32a46a8daa11e9e4edd823fb72f7cb0f4f6c91c3f9455193d40df8a0bbef3296193d33d01e4caf424a8f1b78ff830f4c996a359c3c79925cd2e562638dd258c04d9b3699c3e5fb5c7db539dc5d8f58b8ecb2cb8c652996042856102d59b2d4582debd6ad6b44a99e7d387ec224d1642efa193bf63ee9ddaba7f9bb1e74afd6c3975e5e207ac0ba8a453d77716f5e5e098b59cf1e57c9dd77df69ac912a0c55e0a805b44b978b8fb848d476b80f8d57a69ad574cedcb9a63efa8946246a1f0d1d3258ba75ef2647356a647eaf6753aa2bedb4e9ffc9d41a2ea62f564ba2ba7cc6da1fe1eae3e6a271a6effe75918c1a353a941555fbb27fffdba565cb962636556364d7ad5f2fd3a6ce088dd9a827033f800004200081a8082012a3c2c5c5108000044a4fa0419786927e4a6d496f982e35326a9428b0f060a1ecddbe57f2f7e6cbb605b992ffe3c1d2df34c125f8b9749645f5f4088ceeddbb9538f2a22cee459910800004200081542280484ca5dea42d108040b92150e78c0ca9d7b1ae544eab246935ab495ab5ca72b848247f6f8114151d92fddfec979f96fe2485bb0acb4d9b2255b42c45e23befbc29cd9a369571e326c88285af986ab863ddbccee54b09b034020210800004205006041089650095222100010804215029ad92d43ab19654cfaa2e691955e570fe2139b83d5f0e7c7740f2b7e50729a2dc5c539622d1c654eedab54b567cfa77137ba9995433333343f18e79797bcb0d2b2a0a0108400002104834014462a27b80fb43000210a80004ca52246abcde8811c3a57bb72ba57efdfa86e6eeddbb65f17b4b64f2e4a9a178c70a80992642000210800004e242009118178c14020108400002108000042000010840203508201253a31f6905042000010840000210800004200081b8104024c6052385400002108000042000010840000210480d0288c4d4e8475a010108400002108000042000010840202e04108971c14821108000042000010840000210800004528300223135fa9156400002108000042000010840000210880b0144625c305208042000010840000210800004200081d42080484c8d7ea415108000042000010840000210800004e242009118178c14020108400002108000042000010840203508201253a31f6905042000010840000210800004200081b8104024c6052385400002108000042000010840000210480d0288c4d4e8475a010108400002108000042000010840202e04108971c148211080000420000108400002108000045283c0ff01f20bb4a5b78725b60000000049454e44ae426082', 7);


--
-- Data for Name: tbl_campaign_customers; Type: TABLE DATA; Schema: emails; Owner: bulkmail_user
--



--
-- Data for Name: tbl_campaign_groups; Type: TABLE DATA; Schema: emails; Owner: bulkmail_user
--

INSERT INTO emails.tbl_campaign_groups VALUES (13, 4, 5);
INSERT INTO emails.tbl_campaign_groups VALUES (14, 6, 5);


--
-- Data for Name: tbl_campaigns; Type: TABLE DATA; Schema: emails; Owner: bulkmail_user
--

INSERT INTO emails.tbl_campaigns VALUES (4, 6, 'Title of Campaign', 'Something''s 

happening here...', 2, '2025-08-01 00:00:00', 'rogerwilco@blindza.xyz', '', '54321', 2);
INSERT INTO emails.tbl_campaigns VALUES (6, 6, 'another test', 'as it says...', 4, '2025-08-20 01:31:00', 'rogerwilco@blindza.xyz', '', '999888777', 2);
INSERT INTO emails.tbl_campaigns VALUES (7, 6, 'Sundays Closed', 'Change in operating 
hours', 5, '2025-10-29 10:39:00', 'rogerwilco@blindza.xyz', 'sagwatishiburi1@gmail.com', 'Dr Sunday Operating Hours', 2);


--
-- Data for Name: tbl_emails; Type: TABLE DATA; Schema: emails; Owner: bulkmail_user
--

INSERT INTO emails.tbl_emails VALUES (2, 'my_first_email', 'Please read and respond', '<h2 class=""><img src="data:image/jpeg;base64,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" data-filename="xl500_small.jpg" style="width: 400px;"></h2><h2 class="">Hello,&nbsp;||title||&nbsp;||full_names||</h2><p><br></p><p>We have the following number on record for you:</p><p>||mobile||</p><p><br></p><p><br></p>', 6);
INSERT INTO emails.tbl_emails VALUES (4, 'just_another_test', 'Hello World', '<p>Hello, ||title||&nbsp;||full_names||</p><p><br></p><p><br></p><p><a href="https://blindza.com/" title="||##redirect##||" target="_blank">BlindZA</a></p>', 6);
INSERT INTO emails.tbl_emails VALUES (5, 'Sundays Closed Campaign', 'Dr. Healer is closed on Sundays', '<p>||title||&nbsp;||full_names||</p><p><br></p><p>Good day ||title|| ||full_names||<br><br>Please note that we are closed on Sundays.&nbsp;<br><br>Best regards,&nbsp;<br>Doctor Healer</p><p><br></p><p>||mobile||</p><p><br></p><p><br></p>', 6);


--
-- Data for Name: tbl_queued_attachments; Type: TABLE DATA; Schema: queueing; Owner: bulkmail_user
--

INSERT INTO queueing.tbl_queued_attachments VALUES (3, 8, 'black.jpg', 'image/jpeg', '\xffd8ffe000104a46494600010101006000600000ffe100224578696600004d4d002a00000008000101120003000000010001000000000000ffdb0043000201010201010202020202020202030503030303030604040305070607070706070708090b0908080a0807070a0d0a0a0b0c0c0c0c07090e0f0d0c0e0b0c0c0cffdb004301020202030303060303060c0807080c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0cffc00011080032003203012200021101031101ffc4001f0000010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffc4001f0100030101010101010101010000000000000102030405060708090a0bffc400b51100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00fe7fe8a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a00ffd9');
INSERT INTO queueing.tbl_queued_attachments VALUES (4, 12, 'chart.png', 'image/png', '\x89504e470d0a1a0a0000000d49484452000003890000021e0806000000163a4a1a000000017352474200aece1ce90000200049444154785eec9d0b9c5555bdf87f730e03230316231a208c5486022a0431297a2b07e58e5d4d13f2d58dd0ca7c70351ff8c25e37cdf75b44b312e9decc02adb47b2754c492b10051ff755141530615aec9f8e031e37066e6ff59bbbb8f670e67ce633fd75afb7b3e9f3ec999bdd6faadefefb7e79cefacbdd7ae1ab1777d8ff082000420000108400002108000042000010888481592481d40000210800004200001084000021080804b0049a41620000108400002108000042000010840204b0049a418200001084000021080000420000108400049a40620000108400002108000042000010840605702ac24521510800004200001084000021080000420c04a22350001084000021080000420000108400002ac24520310800004200001084000021080000420508400979b521e1080000420000108400002108000042090258024520c10800004200001084000021080000420802452031080809904264dfaa47cfd6ba7c9d4a95365c8900f4bbf7efd9c89747474c8ebafbf214b1e78407ef2939fcab66ddbcd9c60c851dfff8b9fcb61871dea8ca218cd9b77b92c5ef240c8a37aef7ee68ce3e5ca2baf9041836afbec2493c9c87befbd27cf3cf3ac2cb8f32e79eaa93f791f30af65fef84f3eb9424e3ce914e7a8623f0b2c00cd3b9a7be10572f6d9674a757575af487ffbdb87e4ccb3e6ec12fda1874e955b6fb949860d1bd6eb67ebd6ad97c31b8f0864b6c3870f976f5f7e99d4d4d4c8695ffb46c57d92d78a91d1000210b090002b891626952941c05602dffbde77e4a4134f90c18307f739c59e9e1ef9dbdf5e91ef7deffbb2ecf1e5b6a2f03c2f1b2531178612dfbb7ef423b9f1c69b3d33ca6d882416c7d89724befaeaabf29559a7cadffef6b75e1d9c75d61972c1f9e7390297fb0a4212d51f12bef6b5d3e4b4534f95a143f7905ca1afa41890c44a68712c0420602b0124d1d6cc322f085846e0e69b6e902f7ef1b8ecca61a9e9bdf1c61bf2adf32e90152b5a4a1dcacf352650ce4a627ef86a55f187575d233ffbd97ff89e19c2e04d12b76edd26dff9eef7e497bffc55af0e16dc71bb7ce10bc7ecd269109248ae7c973b1d40000210c812401229060840407b0273ce3e4bce3befdcecea835a2d549716fef4a7f7c883bffe8d4c9c3041ce38e374993efd4819306080331f75cca38f3e26b34ffd9af6f323c0be0994fae2af727fecb1c7c8f1c71fefac1eb9af575e79c5b9d450c9879f57a9f1fdf46d43dbbe5612bbbbbb65d1a2ff9079977f3b3b4db5d2f7dbdffe5af61b330649b421f9cc010210b09a009268757a991c04cc27a0be582e59fc2b39e080f1ce64bababae4c1077f2de77eebfc5d2677f1c573e59ba77f232b8a7ffffb5b72fef917f4baecf4e4934f74ee691c3d7a74563a559f6af5495d9e7ad555d7c8a64d9bb27de77e095697327ef77bdf73ee879cd678b87ce8431f728e7bf3cd37e5273fb947e6dfb140d4fd50975e7ab14c3ff208e7b25875bfdc860dadb2e0ce3be5befbeecff69b7f6f96fa99129baf7ce55f65c488e1924ea7a5bdbd5d56af7e5aaebdee7a59b3e6995de6eb8ed578f8e764f7dd7777daa897ba3f535deef7e39ffcb4d798ea67a52e3775fb74e7a7beecbff1c6266755ee7ffff77fb3f707eedcb953e6cf5f20d75d7f8333663ea76f7fe7bb326eecfe72ec71c7ca9e43873ac728c68f3eb66c17c6c5aab45c49530caebdf66a87bf7a29ee77fde86ef9e10fafeed5fde73efb59b9e082f364ecd8fd65b7dd7673fe98f0eebbef3a9726aae3f339577ab9e9adb7dddeeb9ebb17d7ad932f7ce1b85dee91fdcdaf1f904f7d6ab213db3befbc23175f72993cfcf0efb2b1ba75fab18f7d4cfaf7efefd4fd962d5b1c7eea52dadc1acdcfab12e32757ac902fcd9c2983070f92f7df7fdfe1515bfb8ffb3a0b9d17eafd134ef892fcfbf7bfe7b451afc71e5b26b3be7a6ad15f22f992a872acee131e3870a053bbc71e777cb6fd178f3b56aebcf207ce79b37dfbf66c3cea80422b8995e42ab7aef30376efbd55efbbf7b7aafa5d78ef22f9a7c30e954f7ce213924aa5e4ef6fbd2577dffd6379f37fdfec751f6ca1cb56d5bdd1ea778dbabf57cda7aaaaca61dcd6d6d6678e542d9d7ada6cf9c4befb3a7c541b557f3b76ec90575e795516de7bef2ee76b51f8fc1002108040880490c410e1d2350420e09fc057bf3a4be65d7649f60be56bafbd2e679e75764169524279fffdf7c947f6da4b9e7deeffc9ef1efe9db3d2e8bef225b25074cf3fffbc9c75f6bf6557a072bf04ab2f96efbcf3aeecb9e73fa427f7a5be88df73cfbd72f0c10d3261c204e70b60ee2bff12c87c497cf9e5bfc9e8d1fb64452fb7ad128279977f477efffba5d9b7c78cf984dc31ff36193b766c9f90554c4a7caeb9e6baec31c52451f539ff76d5e7febbc4affa6a6efebd4c9b36cdd944a698242ab9ddbc79b323e2f91cd49762f5a5fbebdf38bdaccd85ca954435c1abafba52befce5539c2ffcea95ffe5fefcf3bf25df3cfdf43e37c1519cd51f09963cf0609657a592a836b55974ef3d326d5aa3d347a1cb2e8f3cf208b9feba6bb32b9ff93275dd75d7c89766ced8653318d59fe2b76efd7a9937efdbbd36e8c9cdab1ab37fffeaec1f4b543b25f87beeb9a7c3a62f81bee1faebe4c413bfe4e44cfda1e1861b6f923beeb8b3e8499c2f896a9cf7dfef94fafa514e0d9c73ee79d94bbeafbce207326bd6bf3afdaf5cb94a9468b91bdee44b62a5b9aa5412150325aaee1f7ad424d5bfaffce1d5b27ddbb6a29278d24927c8a5975cd26be53a1792cad1f3cfbf2067cff9e0f74839bf7bd439f5abc54b64eedc8bfdffe2a407084000023e0920893e01d21c0210089780fbc5d2fde2bf74e92372ea695faf7850b5d274e38d373882a7bec43dfef872b9e8e24b1d31bbe28a7f97fdf7dbcfe9b398fc941a547df154ab79f962e4b6fbf39f57caf133bee4fcb3af5d1efb1a63eddae7e59b679c95dd0864feedb7cab1c77ec1194bad5e5c77fd8df2c0030fc8f9e79d27b367cfca0a42fe4a5631495c78cf4fe48823a6f519bf62a3f2a0e6e88793fb65fcde7b1795425ad10ea2eacbbb5a097357cc72374f513ffbceb72fef25058506cfbf4cd58b24e66ecea26aedfefb7f25175c38373b9c8ae36b5f3bd55971cb1736b5a98bda2dd4bd6cba2f40ab56ad967ffdcaacac689792a4fffaafff92c6c6c6acd8e4d6a21a23ff52d0be369ec98f275f129518ae5fff92fcd33f1de6ac60de74d32d72dbedf39d66eeeaa95a396bfefd5239e6e87f2928895e72556afe6a175ff5ea6ba75cf712f6934ff9b234fdf33ff72989eabc55f7478f1831a268ede65eee9efbbb47adccab15da1f5e75b5a8fba6e75d76a99c78e209d97cab55e5cbe67d5b7ef39bdf963c37380002108040980490c430e9d2370420e09bc0cffff367f2d9cf7ec6e9477df1facf9fdf27175f7c69c5fde6ca66fee576175f74a19c79e619d92facead2cf0be75ee48c91ff25585df6f7c8238fca35d75e27ff74d86172e185e73b977aba2ff5c558ad06dc317f81a855d05c61532b5567cf3947d417f44292a856616eb9f57659b264899c7efa37e4f46f7c3dbb936bae4ca8fbf0eebcf30e19356aa4c3447da154fdba5ff67ff7f043b2efbe1f77fe9dbf9ad397241ed5f4cfa256b0860c19e2b45312a82eebbdf6ba1b64e28483e4bcf3be25e3c68dcd0a642949549cfef4a73fcbd5d75c2ba3468d721e49e05e0a5a491e2b5949cc679a3bf70796fc4a3efde906676e2ab63f3ef9a47cfffb3f903df6d843befded7972d08107662f19ccbd4cd58b24aa4b447fb6e81e672555bdf2453d3796dc5a54ed94a87ffce31fdb25070d0d53e4a2b91764fbcc17ed7c49522bd737df72abdc75d7ddd9dacc1d37bf2e722f35cdafa962275b21495497c4aa5d889504bb7fd4c9cd8d1afbe1dffd977c75d6570a4a6218b95273c8cfa59aa77a5c8aba6f32f7ded56239cffde38c6aaffe7873d34d373b572e7ceb5be7382bc0aee0bbb99d3c7972f63121851e3ba37ec78d1f3f5ed6ac59238f2f7fc2f9630f8ff0a9f8573c0d200081800920890103a53b0840205802b95f7ef3c524a891f2bfe8e65ea698ffb3bffef57f64c6cc2f65bfc4fdea97bf90a9530fc986927b1f57be2ce47e31cf171ab5ba72f5d5d7ca4f7e7a4fb6afef7ee77239edb47fac38a9d7134ffc414ef9f2574a4efbf1658f8aba7454bdf2bf94f62589b9ab5baa5dfefd68ead2c00577cc979123f7ce0a4c5ff724aa03d4e5b36ad320f71108f92bc2b9225e6c427e2471ebd6ad72e9a5f364dbf6edbd2eefcccf61ee4a8f8a25f7f24f2f92a8fac89589dc4b4ef3c7caadb5534ffdaa5c76e925cefd6a8572907fe975eeb308f325b1d0730a2fbbec12e73e3a554ff9e752eea5a695acf4e69f1f4ab66ebdf536b9eaaa2b9d3f70b82b924d4dd3b38fbef8cb5ffeead457eef315ddcb4df32fc50d2a578524f1adb7b6387f0c527ff4c97df595f3fcf3b9d0bd9d4b96fc523efeb18fcbeaa79fce5eee9ecb48ad24aa3f12a94b79837c9e67c95f0a1c00010840a04202486285c0381c02108896405892a8244d6d3a71d8a187ca7efb8de9b589463149fcd5af163b8fd6705ff9f12d5870a75c73edf5d99fe70a5b31492c74795ffe17e6be1e13a056e83ef7b9cfc8673ff319993469920c1bf691ecbd8de54a62eea3093a3b3b456dc0a22e15cc7de5aeea965a49cc17da7c99884212ddb90fde7d702ff92a2450cdfffd3b39f0c0039ce9e6aef87a95c4fc9539f792d35c51cbbf1c33ff3254b519d2bfffe08a6c0a725790d59b2fbcf0824c3be29f9d9f97739ee4ff61c2adf3fccda1f2c5acd8195f4812bff6f5d3b32ba9ae201ffeb9cf3a8fbe702fbf7dedf5d7e49c7f9be36ccaa35e6e6de78b7250b92a24897d9d4f7de53cff7c54b2db74d4bf94fc8598bf21906aa056b3376ffe5f67f550dd6b9c7bef74c90e390002108040040490c4082033040420e09d40fe0a49b972516844b55ba27a54865a1573ef5b2b745c3149cc1fbfd497f37225b1d017d6fc2ff5b9c7a82ff673e69c2dc71d7b6c7637d442732957124bed7aaafa569bada85d37d5ab9424e6738a43125d299f7ac821bd56ad4a55a3daad56ed9efb873ffcb1e83d91c504325fbcdc4b4e17ddbb307bd96bfe264cb97c4bc5a87efed24b2fcbbf1c7d8cb35a5c4efe549bdc4d755c3e7bedb96776d751b5d2f59ffff973b9e4d279e584b0cbe5d86e8dbaf1b88fc23864eac1cea32fdc0d71f2771075dbf5f5488dbe822937578524b1d0aea5c58eab64553b3f5ef50796cf7ce69ffabcdf57ad7a2f7de4d18a76fe2d2b411c04010840c0230124d123389a410002d110b8e69aabe4cba79c9cfd7255ea92cbbeeeef518f96b8e4e2b9f2e10f7fd8095cad68a8fbb6fedffffb8bb372f4c52f1e97bd3f4a77495402f2a3bbeeecf5a5d37dd4c6934f3e29871d7658f6beb6244962fe97f88d1b5f9333ce384bd40a50eea58da52a379799d795443546ee6eab6a43929b6fbe55ce3efbaceceeb8f99b30552a89b92bd3e54ae2bfcd39db79e6a8ba6fce5dc9dc7bef11d95d610b3d8ea318af422b8987371e21b997172b99fdc8473ee23c5ac395ba7f88e915d99d66bd4a62b9b98a5b12d5397bf1c517c98ce3bf5874f324f587834b2fbdacd7637b4ad52b3f8700042010060124310caaf4090108044620fff2b3628fc0c8bf6f2ef75eb0dccd30d497637529df953fbcca89b3d82a57a915b0a05612732f7174e1f575b969febd69eab2c3b9175d927d2c485fab97aadfbe6422e8cb4de35849ccbfafd2bdb73077b751c520ff92e162c5ea47128f3efa5fe49aab7fe8fc6142ada8a98d7ca64cf994f3c708750faadae1523d36c57de58a955aa9cdbf74b9589ce54a62fe39a2ee0ddc6bafbdb297dae63f8ea3d4899c7f7eb89760e65e62a9e6ae76e155ff737f9ecfd595c4b072158424e69f8fb997fb96e2e4fe5cc9e2f1c71f2f9f3faac961ee3e63d1fd79259b06953b26c741000210f0420049f4428d361080406404f2777c54f7f2a85d37d5e580f9afdb6ebb458e3bf60bd9e7e4b9f756a9e716de7acb4d326cd830a749ee657aba4862a14d7972ef5f5371baaba8f9977d967b1f6431492cb5718dda70e5faebaf755684d44bb7cb4dd5463d6ac7577549a37ae5ee065b6a3394b02451f59bfbc70975afa77b0f5efec63eead8521bd7042189aa8f7b7efa63993efd48a7bbb7df7e5baaabfb3b2b7a7d3d3fb1d8b87d6dfa947fffa4db877b8f615f921864ae5a5a9e922f9d705236fc722f172d77e39a77df7dd7795e65eefd84eadcfcfce79be47ffe67ad3cbe7cb93cf8e06f9c2b15fa7a294ee79efb6fce7335d5a365d4abafcb6023fba5cb4010800004440449a40c200001ed09e43f3b4e89a25af1f8d9cffec3f982a604e68c33be29071ffce9ec172db55aa876df54bb08e6dfdb97bf494cee7d5a0a46ee661951ad24aa71d597ce1fffe4a7f2a31fdd2d5f9d35cbb97fb2aeaecec94fee2627b992a8bed8e76e70f2c5e38ecdde5fa6dae5efe0d8d78a53feae9bf98fc0b8e4928bb38fd5d04912d5a63deaf11da79c7292ecbffffed9cb92f39f7798ff5805b5aa77d3cdb7c8abaf6e701e5df085638e763612f9f39fff2cbff8c52fe5d9e79e73b8fb594954edf3455fbdd7d76a51a147603437ff5e6ebce96627968b2f9aebd4f22bafbc2a7ff8e31f65c99207b28f6e28772551f5932fa3ee2f80fcc76294f38ba1d8cec0f93bffe66e88546c5326afb9caef73436babcc99738e0c1a34c87976e3a1530fe9f3f987b9732df71118aa8dfa83d3d5575fe33c5225ffb135ee1f52d4eea9ead98f9ffef4a7e5431fda5d7ef0832b7b8965fe78a52ea92f272f1c03010840c02f0124d12f41da4300029110b8e5e61b9dfb06ddbfb6171b547d09577f8dfffa374ecf3eaa2277f74a2599bff9ed4372fd75373882907b3fa2ea378e7b124b4154cf63fbe61967398f94c8bf244fad54ccbbfc3b525353d3eb597aaacf72ef4954c7aa67f41d71c4b43e37d7c88d31ae95c4529cd4cfd5e6286a67d6dbe7df913dfc6ba79d2a975c7251f6f1127df593fb10f42024b1d0f330732f83ce8f23ffb1277dc5a96af8673ffb4fe7197fea558924e6cba83b46fe634fca615d4c12f31f7b92fb078b629b3279cd957a0ea67af488fb3c4e377e574e37b66ef42d892aee9b6fba41468c1851128fba1cf51ba79f29dff9f6bc5ee79512cb9b6fbec511c5430e39d87934888a3d954a15acdd9203710004200081100820892140a54b0840201c023ff8c1f7e594934f7264a8af975a59fbc31f9f948b2ebaa4d7655e6ae39acb2ebdb8d783efdd3e9418a8fba65c01cd7df879542b896a438f542a2d4387eeb1cbd49404aaf92c7b7cb9f3337569e08feffe91f3080f759f57fe4b315073513fcb97b96232a12ed99c7ffb6d3276ec072b726edf4abcd4e5bb9ffad464e72d5d2551ed12f9a3bb7f2c37def88fd5b7dc979216b53babfbb0f3fc9fab3a78eeb9e7e4bcf32fccaed0f95d495463e4af54177bc484caed8d37de204dff3cbdcf3f8828415cbefc0939ebec39d93f825422892aa6dce738aa7fe73f8ea3dc33b89824e6af58e69e57c524518ded2557aa5dfe6ec86eadaa4bb2d525beb99be554babba9cb44ad0a5e7ac92505cf55f71875ce5e75d535b2e481079d6796de74e3f5a22e7b2f74beba6dd479ab2ea5cf7dc44eb979e038084000024113401283264a7f108040a804d45fdebf3aeb2b72f0c1074b5ddd10e78bb4fa72af56cc5e7cf145e712d4c54b1e281883128433cf3843f6d9a7de79a0b85a6178e5d557e5fefb7f29eade20f51c37f5ca7d98785492a836eeb86cdee5cef3fcc68f1fe7888c8a433d785b5d16b966cd33bde6a4564bbe7df965d2d8d898dd21525daeaabef83efad832b97cde65d92fb1aa8fe3677cc9695f4a2654bf975e7ab11c31add1116a25cf1b366c903b16dc2993274dce3e02c37d94c11d77dce9f45b8a53a99ff75534f99256e838f5e5faedb7df91969616e772dd7c56b96d547fa79e36dbb97771b7dd76737ea4ea405d6afa9bdffe566ebf7d7e56bcd4cf8290c4dc95df721f31f1cd6f7e434e3cf104f9e8e8d1d9fb1815737509a5aad7bbeebabb178a5279cde796ffec3e772758f732db724fe2fcbce65eaa9dbfb297bb9b6b294974d957922bd5466dcc73d1dc0ba5a1618a730e29a1deb2658bdcfde39f48fe6337bc4aa23bce374fff86f3871a77f319b70e9ff8c31f64fefc3bb27f6850c72bf95797901f77dcb1ceef9f8103073ac2a87e77a94d8cd425c40befbd57d4864fbc20000108e8400049d4210bc4000108248e40395f92758392bbe149fe65acbac54a3cc509e4ef905be8a1f530840004200081e4124012939b7b660e0108c448403749542b66f32ebf4cdefafb5bb272e52af9affffe6f59b1a2c521a45617bff2af5f96d34e9b2d83070f76de2bf4c88e187132741904d4bd88ea9e56b5d14fee4644b92be76574c321108000042090000248620292cc14210001fd08e82689f9bb9b162396bfb98b7e7489a81081c71efdbdb3036cfeabd83d929084000420008164124012939977660d0108c44c40374954382ebe78aea8fbacfadad8c545a6ee9fbce0c2b945effd8b192fc3172050685397f7de7b4f7e78d535cebdbcbc200001084000022e0124915a800004201003011d25516150979daa9d60d58e8cb5b5b5d91d36d5a61c6d6d6dcea6386ae7d0620f088f0127439641e0de853f95c30fff9c935395cf975e7ac9d9e887cd52ca80c72110800004124600494c58c2992e04200001084000021080000420008162049044ea0302108000042000010840000210800004b20490448a010210800004200001084000021080000490446a00021080000420000108400002108000047625c04a22550101084000021080000420000108400002ac24520310800004200001084000021080000420c04a22350001084000021080000420000108400002450870b929e5010108400002108000042000010840000259024822c500010840000210800004200001084000024822350001084000021080000420000108400002bb12602591aa80000420000108400002108000042000015612a901084000021080000420000108400002106025911a80000420000108400002108000042000812204b8dc94f280000420000108400002108000042000812c01249162800004200001084000021080000420000124911a80000420000108400002108000042000815d09b092485540000210800004200001084000021080002b89d40004200001084000021080000420000108b092480d400002108000042000010840000210804011025c6e4a79400002108000042000010840000210804096009248314000021080000420000108400002108080be92387bf62cd9b66dbb2c5ebca4579ad4fb7bd4ede1bcd7d9d9298f2d5b266bd73e9f3d66ead443a4a1618aa45369e7bd0dadadbbf441de21000108400002108000042000010840a03801ad56125d11cc17bc993367c8f061c3b262a88eebdf7f803437374b6beb4619376eac4c6b6c944d9b373b62e80aa392c8a54b1fa10620000108400002108000042000010840a04c025a48a22b79e97e69e9ca7465654fcdc1fdd98bebd665852fff3d2591757575596954ed0abd5726130e8300042000010840000210800004209058025a48a212ba41836a65d9b2c7a5a9a949dadadab2978aaa55c1c99326c9d36bd6484bcb53d944e55e96aafe5bbd162e5c94fdb96a3771e20459befc895e97a52636d34c1c0210800004200001084000021080401904b4904437cefafa51bb48e2f4e947ca7e63c6ec720fa22b8685c452f5d7975c96c184432000010840000210800004200001082496009298d8d43371084000021080000420000108400002bb124012a90a08400002108000042000010840000210c812d05e1283be27b1baba5a060ce85fb204de7fbf53d4b1a95455c96339000210d895404d4d8da8f3a8a7a71b3c1080408504387f2a04c6e110c823c039444940c03b0175fe682f8941ef6e9a4aa5a4aaaab4f82941cc6432d2d3d3e39d302d21906002b5b5b5d2dede2edddd486282cb80a97b24c0f9e3111ccd20f07f0438872805087827a0ce1fed25514d2f8ee7242a83eeecece40baef7faa265c209a81d8bdbdb3ba4abab2be124983e042a27c0f95339335a40209700e710f50001ef04d4f9638424aa29aadd4cf7a8dbc399ad92b7c7962debf5680b75596a43c31449a7d2ce311b5a5bb38fd1f0820849f4428d3610f880001fd0540304bc13e0fcf1ce8e961050043887a803087827a09d247a9f4af02d91c4e099d263b208f0019dac7c33db600970fe04cb93de9247807328793967c6c11140128bb04412832b347a4a26013ea0939977661d0c01ce9f6038d24b7209700e2537f7ccdc3f01241149f45f45f400813e08f0014d6940c03b01ce1fefec680901458073883a80807702482292e8bd7a6809811204f880a64420e09d00e78f7776b4840092480d40c01f01241149f45741b4864011027cc9a53c20e09d00e78f7776b4840092480d40c01f01241149f45741b4860092480d4020140248622858e9344104388712946ca61a38012411490cbca8e810022e013ea0a905087827c0f9e39d1d2d21c04a223500017f04904424d15f05d11a02ac2452031008850092180a563a4d1001cea104259ba9064e00494412032f2a3a84002b89d40004fc13e00bae7f86f4906c029c43c9ce3fb3f74700494412fd5510ad21c04a223500815008f0053714ac749a20029c43094a36530d9c00928824065e547408015612a90108f827c0175cff0ce921d9043887929d7f66ef8f00928824faab205a438095446a0002a110e00b6e2858e9344104388712946ca61a38012411490cbca8e81002ac24520310f04f802fb8fe19d243b209700e253bffccde1f01241149f45741b486002b89d400044221c017dc50b0d2698208700e2528d94c357002482292187851d121045849a40620e09f005f70fd33a4876413e01c4a76fe99bd3f02482292e8af82680d015d57125369e919375364ef0691a1fb9327085446e0cdbf88bcbe4aaad62ea9ac5d8047f305374098749548029c43894c3b930e880092882406544a7403815d09c4f6015dbd9bf41c778ff4abdd4dd2d5223da934e981406504ba32d2bdb347325b3649d5c36755d636a0a3633b7f028a9f6e20103701cea1b833c0f826134012914493eb97d8352710d707744fe315d27fdf8992daf3a39a13223cdd0974bdf182649efb6f91353f8e3cd4b8ce9fc827ca8010088900e7504860e9361104904424311185ce24e32110cb07f487eba5ea0bf3a5ffa88fc5336946b58ec0fb1b3788fcf2cb221d6f473ab758ce9f4867c86010089700e750b87ce9dd6e0248229268778533bb5809c4f254e8778d000020004944415401fdf1232535f914a9fe4443ac7367707b08ec7ce57fa4fbf7978b6c5917e9a462397f229d218341205c029c43e1f2a577bb09208948a2dd15ceec622510c70774cf01274a7af4a7a47ac2e7639d3b83db43a073dd4ae959719bc81b6b229d541ce74fa413643008844c80732864c0746f3501241149b4bac0995cbc04e2f8804612e3cdb98da32389366695392581401c9f4149e0ca1c9341004944129351e9cc321602717c402389b1a4daea419144abd3cbe42c2610c76790c538995ac20820894862c24a9ee94649208e0f682431ca0c27632c243119796696f61188e333c83e8acc28a90490442431a9b5cfbc232010c70734921841621336049298b084335d6b08c4f119640d3c2692780248229298f8930000e11188e3031a490c2f9f49ed19494c6ae699b7e904e2f80c329d19f143c025802422899c0d10088d401c1fd0486268e94c6cc748626253cfc40d2710c76790e1c8081f025902c648627dfd28696a6a92c1830639c16fddb64d9a9b9ba5b57563763253a71e220d0d53249d4a3bef6d686d95c58b97784e774d4d8d7476764a7777b7e73e680881241388e3031a494c72c585337724311caef40a81b009c4f11914f69ce81f0251113042125d4154505c319c397386d4d5d565ff3d6edc5899d6d8289b366f76c4d015c6b56b9f97a54b1ff1c41349f4848d4610e8f557a8f6f60ee9eaea8a8c0a921819eac40c84242626d54cd4320248a26509653a911230421295f04d9e34499e5eb3465a5a9e7200b9e2f8eaabaf3a12982f8dea9842ef55421749ac8416c742605702717c4023895462d00490c4a089d21f04a22110c767503433631408844fc008499c3efd48d96fcc18796cd932512b83ee6bf6ec59b26ddb7667e550fdb77a2d5cb828fb73259713274e90e5cb9fe8d5ae5cac4862b9a4380e028509c4f1018d24528d4113401283264a7f108886401c9f41d1cc8c5120103e012324b1d84a6267e7fbb26cd9e3cefd8a6d6d6dbdee412cd4ae12a4486225b4381602bb1288e3031a49a41283268024064d94fe20100d81383e83a29919a340207c02464862a17b12d5eae281071c205bdab62089e1d7092340c01381383ea091444fa9a25111024822e501013309c4f119642629a28640e13ff4578dd8bbbe477738f9bb9b2a39745f95ae24565757cb8001fd4b4e3993e992743a2d5555250f0df1802aa9ea2722a9588308717e741d0a816e919e4cfcbbf20e1c582b1d1d1dd2dd1dddc6359d6366484ffd2725357e7a2868e934790432eb574bf5eabba4df9bcf453af938ce9f4827c86010089900e750c880e9de6a02eafc314212f3b3e04aa37b896925f724a65229a92ac3fc944c663219e9e989dea1abfa55c9878f182203f7df4d52e994088e68f58918f8e47a44ba33ddf2f663efc88ebf6e0fbcfb723bacadad95f6f6f6481f23d33dfe0449ed3359fa1d7454b961721c048a12d8b96e9548cbed52b5f9994849c571fe443a41068340c804388742064cf7561350e78ff692e83edee2c575ebb28fb3c8bfdfd0aadd4d5322f5e7d6cb6e037793811f192855ac225a7d128635b99def75cafb9d3ba56df51679ebe1b7c21aa668bf715ceac3e5a6b1a4daea41b9dcd4eaf432398b09c4f11964314ea696300246dc93a872a2560afbf71fe03c1751bdd446356ad31a7737539b9e935877449d0c9950271ffae8ee092b47a61b06817737bf2bad776e949d6f7586d13d92183955068c9a0092183571c68340300490c46038d24b320918238985ee49cc7ddc854a9f5a5d6c689822e954dac9e686d6d65ebb9d569ae2587637ad12a93fbf5e3ebcd787a55fadba19911704fc1178f7c5f7e4add57f97779f7ad75f471e5ac7f101cd4aa28744d1a4280124910281809904e2f80c3293145143605702c648621cc98b431253fd5332f29c913274f4d038a6cc981612d8fad236d9fede5679e3a79b229f5d1c1fd04862e469b67e4024d1fa1433414b09c4f11964294aa6954002486291a4c722893529193907494ce0b918da94df5bb7553abadbe5b5db5f0b6d8cbe3a8ee3031a498c3ccdd60f88245a9f6226682981383e832c45c9b41248004944121358f6c99a329298ac7c33dbe0092089c133a54708444100498c823263d84a004944126dad6de6f57f0490444a0102fe082089fef8d11a0271114012e322cfb83610401291441bea983914218024521e10f0470049f4c78fd610888b0092181779c6b58100928824da50c7cc0149cc12e09e444e87a00920894113a53f08444300498c8633a3d84900494412edac6c669525c04a22c500017f0490447ffc680d81b80820897191675c1b08208948a20d75cc1c5849642591b320340248626868e91802a112401243c54be7961340129144cb4b9ce9b192480d40c01f0124d11f3f5a43202e0248625ce419d7060248229268431d330756125949e42c088d0092181a5a3a8640a80490c450f1d2b9e504904424d1f212677aac24520310f0470049f4c78fd610888b0092181779c6b58100928824da50c7cc8195445612390b422380248686968e21102a01243154bc746e3901241149b4bcc4991e2b89d40004fc114012fdf1a33504e2228024c6459e716d208024228936d431736025919544ce82d0082089a1a1a56308844a00490c152f9d5b4e004944122d2f71a6c74a223500017f0490447ffc680d81b80820897191675c1b08208948a20d75cc1c5849642591b320340248626868e91802a112401243c54be7961340129144cb4b9ce9b192480d40c01f0124d11f3f5a43202e0248625ce419d7060248229268431d330756125949e42c088d0092181a5a3a8640a80490c450f1d2b9e504904424d1f212677aac24520310f0470049f4c78fd610888b0092181779c6b58100928824da50c7cc8195445612390b422380248686968e21102a01243154bc746e3901241149b4bcc4991e2b89d40004fc114012fdf1a33504e2228024c6459e716d208024228936d431736025919544ce82d0082089a1a1a56308844a00490c152f9d5b4e004944122d2f71a6c74a223500017f0490447ffc680d81b80820897191675c1b08208948a20d75cc1c5849642591b320340248626868e91802a112401243c54be7961340129144cb4b9ce9b192480d40c01f0124d11f3f5a43202e0248625ce419d7060248229268431d330756125949e42c088d0092181a5a3a8640a80490c450f1d2b9e5048c92c4d9b367c91e757b3829e9ecec94c7962d93b56b9fcfa668ead443a4a1618aa45369e7bd0dadadb278f112cf29aca9a971c6e9eeeef6dc47a50d533529193967a40c1d3db4d2a61c0f8182045849a43020e08f0092e88f1fad2110170124312ef28c6b0301632471e6cc19327cd8b0ac182a61ecdf7f803437374b6beb4619376eac4c6b6c944d9b373b62e80aa392c8a54b1ff1942b24d113361a69460049d42c2184631c0124d1b8941130041c024822850001ef048c90c4fafa51d2d4d4246d6d6dd99541570a5f5cb7ce91402591757575596954480abd57092a24b1125a1cab2b012451d7cc1097290490445332459c10e84d0049a42220e09d803592a85616d56be1c245591a6a3571e2c409b27cf913bd2e4b2d171792582e298ed3990092a8737688cd040248a20959224608ec4a0049a42a20e09d801192e8ae0ae65e6e9a7bf9e9b66ddb765969546d94244e9e34499e5eb3465a5a9eaa9812925831321a68480049d430298464140124d1a874112c04b20490448a0102de09182389ae28ee535fefcc76ebb66dd94b4b0b5d8e8a247a2f0a5ada450049b42b9fcc267a024862f4cc1911024110401283a0481f4925608424ba12d8d9f97ef672d2e9d38f94030f3840fef2d7bfca0b2fbc50d14a627575b50c18d0bf64ce33992e49a7d3525555f2d0c00ea81a909221a70e6177d3c088d2d18e9777c8f6cc7679fb9eb6c8610c1c582b1d1d1dd2dddd15d9d89d6366484ffd2725357e7a64633290dd0432eb574bf5eabba4df9bcf453ad138ce9f4827c86010089900e750c880e9de6a02eafca91ab1777d8fceb35442b8df9831bb3cf222f73ec44aee494ca552525586f92999cc6432d2d3131d1ef5088ce1670e4712752e48c362dbba7eabb477b5cba6059b228fbcb6b656dadbdb237d8c4cf7f81324b5cf64e977d05191cf9701ed24b073dd2a9196dba56af333914e308ef327d2093218044226c039143260bab79a803a7fac90447637b5ba4e999c0f025c6eea031e4d21a09ecbbb6ea5f4acb84de48d3591f2e052b948713398850438872c4c2a538a8c8015979baa4760f09cc4c86a86810c2380241a9630c2d58e0092a85d4a08080265114012cbc2c441102848c008495491bbf7250e1e34c89948577797ac5cb9aad7aea56a37d3868629924ea59d6336b4b6669fabe825ffec6eea851a6d74238024ea9611e2318d0092685ac6881702ff208024520910f04ec01849f43e45ef2d9144efec68a90f0124519f5c10899904904433f346d4104012a9010878278024166187247a2f2c5aea430049d427174462260124d1ccbc11350490446a0002de09208948a2f7eaa1a51104904423d244901a134012354e0ea141a008012491f280807702482292e8bd7a6869040124d1883411a4c60490448d934368104012a9010884420049441243292c3ad5870092a84f2e88c44c0248a29979236a08b092480d40c03b01241149f45e3db43482009268449a0852630248a2c6c9213408b092480d40201402482292184a61d1a93e0490447d72412466124012cdcc1b51438095446a0002de09208948a2f7eaa1a51104904423d244901a134012354e0ea1418095446a0002a110401291c4500a8b4ef5218024ea930b22319300926866de881a02ac24520310f04e00494412bd570f2d8d2080241a912682d4980092a87172080d02ac2452031008850092882486525874aa0f0124519f5c10899904904433f346d4106025911a80807702482292e8bd7a6869040124d1883411a4c60490448d934368106025911a804028049044243194c2a2537d082089fae48248cc2480249a9937a286002b89d40004bc1340129144efd5434b2308208946a48920352680246a9c1c4283002b89d40004422180242289a114169dea430049d427174462260124d1ccbc1135045849a40620e09d009288247aaf1e5a1a41004934224d04a931012451e3e4101a045849a40620100a012411490ca5b0e8541f0248a23eb920123309208966e68da821c04a22350001ef04904424d17bf5d0d2080248a2116922488d0920891a2787d020c04a22350081500820894862288545a7fa104012f5c905919849004934336f440d015612a90108782780242289deab8796461040128d4813416a4c0049d438398406015612a9010884420049441243292c3ad5870092a84f2e88c44c0248a29979236a08b092480d40c03b01241149f45e3db43482009268449a0852630248a2c6c9213408b092480d40201402482292184a61d1a93e0490447d72412466124012cdcc1b51438095446a0002de09208948a2f7eaa1a51104904423d244901a134012354e0ea1418095446a0002a110401291c4500a8b4ef5218024ea930b22319300926866de881a02ac24520310f04e00494412bd570f2d8d2080241a912682d4980092a87172080d02ac2452031008850092882486525874aa0f0124519f5c10899904904433f346d4106025911a808077024648e2f4e947ca81071c5070965bdab6c8c2858b9c9f4d9d7a8834344c91742aedfc7b436bab2c5ebcc4339d9a9a1ae9ecec94eeee6ecf7d54da30559392917346cad0d1432b6dcaf11028480049a43020e08f0092e88f1fad2110170124312ef28c6b03012324b11068258ee3c68d95952b57494bcb53ce7f4f6b6c944d9b373b62e80ae3dab5cfcbd2a58f78ca1592e8091b8d342380246a9610c2318e0092685cca0818020e0124914280807702464a62be10aae9cf9c3943eaeaeaa4b9b9595a5b373a440abd57092a24b1125a1cab2b012451d7cc1097290490445332459c10e84d0049a42220e09d809192387bf62ce9df7f402f2154efa9977be9a9fa6fb59a3871e20459befc09512b8a95be90c44a8971bc8e0490441db3424c261140124dca16b142e003024822d50001ef048c93c4429791d6d78f92a6a626696b6beb750fa23a76f2a449f2f49a35ce25a995be90c44a8971bc8e0490441db3424c261140124dca16b1420049a40620100401e324b1d025a4486210a5401fb61240126dcd2cf38a8a0092181569c68140b00458490c9627bd258b805192d8970c562a89d5d5d5326040ff9299ce64ba249d4e4b5555c943033ba06a404a869c3a84dd4d03234a473b5ede21db33dbe5ed7bda2287317060ad747474487777576463778e99213df59f94d4f8e9918dc9407613c8ac5f2dd5abef927e6f3e17e944e3387f229d2083412064029c432103a67bab09a8f3a76ac4def53d26ccb2d8e5a395dc93984aa5a4aa0cf3533299c964a4a7273a3cea1118c3cf1c8e249a509086c4b875fd5669ef6a974d0b36451e716d6dadb4b7b747fa1899eef127486a9fc9d2efa0a3229f2f03da4960e7ba55222db74bd5e667229d601ce74fa413643008844c80732864c0746f350175fe182389eab117fb8d19238f2d5bb6cb4634ec6e6a759d32391f04b8dcd4073c9a424044b8dc943280809904b8dcd4ccbc11b51e048cbadcb4d8232d784ea21e054514fa114012f5cb091199450049342b5f440b01970092482d40c03b01a324b1d025a5b95377773e4da7d2cedb1b5a5b7bed765a29267637ad9418c7eb480049d4312bc464120124d1a46c112b043e208024520d10f04ec02849f43e4d6f2d91446fdc68a517012451af7c108d79049044f37246c41050049044ea0002de09208945d82189de0b8b96fa104012f5c905919849004934336f440d0124911a80807702482292e8bd7a6869040124d1883411a4c60490448d9343681028420049a43c20e09d009288247aaf1e5a1a41004934224d04a931012451e3e4101a0490446a0002a110401291c4500a8b4ef5218024ea930b22319300926866de881a02ac24520310f04e00494412bd570f2d8d2080241a912682d4980092a87172080d02ac2452031008850092882486525874aa0f0124519f5c10899904904433f346d4106025911a80807702482292e8bd7a6869040124d1883411a4c60490448d934368106025911a804028049044243194c2a2537d082089fae48248cc2480249a9937a286002b89d40004bc1340129144efd5434b2308208946a48920352680246a9c1c4283002b89d40004422180242289a114169dea430049d427174462260124d1ccbc1135045849a40620e09d009288247aaf1e5a1a41004934224d04a931012451e3e4101a045849a40620100a012411490ca5b0e8541f0248a23eb920123309208966e68da821c04a22350001ef04904424d17bf5d0d2080248a2116922488d0920891a2787d020c04a22350081500820894862288545a7fa104012f5c905919849004934336f440d015612a90108782780242289deab8796461040128d4813416a4c0049d438398406015612a9010884420049441243292c3ad5870092a84f2e88c44c0248a29979236a08b092480d40c03b01241149f45e3db43482009268449a0852630248a2c6c9213408b092480d40201402654be2cc19c7cb95575e210f3df4b05c38f7a25ec15c7fddb572cc3147cbbc7997cbe2250f8412681c9dd6d4d4486767a774777747367caa262523e78c94a1a38746362603d94d0049b43bbfcc2e7c024862f88c19010261106025310caaf499140248222b8949a9f5c4ce13494c6cea9978400490c48040d20d0422268024460c9ce1ac22505212efffc5cfe5b0c30e2d39e975ebd6cbe18d47943ccea403584934295bc4da17012491da80803f0248a23f7eb486405c0490c4b8c833ae0d044a4aa23bc962979bda00a2d01c90445b339bac792189c9ca37b30d9e0092183c537a8440140490c428283386ad04ca96445b01149b179298c4acdb376724d1be9c32a368092089d1f2663408044500490c8a24fd249140459238f7c20be4ecb3cf94eaeaea5d586ddbb69d8d6b02a82036ae0900225df4228024521010f0470049f4c78fd610888b0092181779c6b58140d99278e8a153e5d65b6e92f7dedb6addbd877d259295441b4a9c392089d40004fc114012fdf1a33504e2228024c6459e716d2050b624724f6234e96625311ace491a05494c52b6996b180490c430a8d22704c227802486cf9811ec2550b624ba2b898f3ffec42ecf498c0acfcc9933649ffa7a67b8aeee2e59b97295b4b43c951d7eead443a4a1618aa45369e7bd0dadadb278f112cfe1b192e8191d0d352280246a940c42319200926864da081a028224520410f04ea06c4954435c7fddb572cc3147c772efe1ecd9b364f0a0c1f2d8b265b276edf3a28471f8b061d97f8f1b3756a63536caa6cd9b1d317485511dbb74e9239e0821899eb0d148330248a26609211ce3082089c6a58c8021e0104012290408782750b624ba979baa06855e616e5c5348f85c297c71dd3a47029534d6d5d5497373b3b4b66e74422cf45e25a890c44a6871acae0490445d33435ca61040124dc9147142a0370124918a80807702654ba2f721fcb79c3efd48d96fcc98ecaa61a11ed54aa37a2d5cb828fb63259713274e90e5cb9f70561f2b7d21899512e3781d0920893a6685984c2280249a942d6285c007049044aa0102de09182189ee8ae0ebafbf2efbefb79f33dbdc7b12ebeb4749535393b4b5b5f5ba075149e2e44993e4e9356b7addbb582e2e24b15c521ca733012451e7ec109b0904904413b2448c10d8950092485540c03b016324516d58b3a56d4b76a55089e3c8917b3b9bd7bcf6da6b48a2f71aa0a5e5049044cb13ccf442278024868e980120100a01243114ac749a1002654b629cf72416bab7d05d3decec7c5f962d7bbc2249acaeae960103fa974c7126d325e9745aaaaa4a1e1ad80155035232e4d4213274f4d0c0faa4a36413d8f1f20ed99ed92e6fdfd316398881036ba5a3a343babbbb221bbb73cc0ce9a9ffa4a4c64f8f6c4c06b29b4066fd6aa95e7d97f47bf3b948271ac7f913e904190c022113e01c0a1930dd5b4d409d3f5523f6aeeff13a4b258fdffdeeb765d1a2ff90ebaebfc16b3745dbf5b5014dee7d8895dc93984aa5a4aa0cf3533299c964a4a7c7339e8a79a8e7240e3f7338925831391af44560ebfaadd2ded52e9b166c8a1c526d6dadb4b7b74b7777776463778f3f4152fb4c967e071d15d9980c6437819deb5689b4dc2e559b9f8974a2719c3f914e90c120103201cea19001d3bdd504d4f9e34b12151df5688cc30fffac9c73ee79b262454be0c00a6d40937f1f22bb9b068e9d0e2d21c0e5a696249269c44680cb4d6343cfc010f04580cb4d7de1a371c209947db969314e513c3f317fa530f79ec49696a784e72426bc92997e9f0490448a0302fe082089fef8d11a0271114012e322cfb836100844121f5ff6a8ecbefbe0d056125dd04a14f7a8dbc3f967eeeea6eecfdde729a65369e7ad0dadadbd763bad3461ec6e5a29318ed7910092a8635688c9240248a249d92256087c400049a41a20e09d40d992586ce39a9d3b77cafcf90b42bb27d1fbf4fcb54412fdf1a3b51e0490443df24014e6124012cdcd1d91279b009298ecfc337b7f04ca96447fc398d91a4934336f44dd9b0092484540c01f0124d11f3f5a43202e0248625ce419d706024862912c2289369438734012a90108f8238024fae3476b08c44500498c8b3ce3da40a06249bcff173f97c30e3bb4d7dc9f7c72859c78d22936f0e8350724d1ba94267242486222d3cea403248024060893ae20102101243142d80c651d818a245109e2c4891365debccb65f192071c18eebd8acf3efbac75a288245a57ef899c109298c8b433e90009208901c2a42b08444800498c1036435947a06c497465f0a1871e960be75ed40b44148fc088833c92180775c60c9a0092183451fa4b1a012431691967beb61040126dc924f38883009258843a921847493266d00490c4a089d25fd208208949cb38f3b5850092684b2699471c04ca9644151c979b869fa2544d4a46ce192943470f0d7f30464804012431116966922112401243844bd7100891009218225cbab69e404592e88a221bd78457174862786c93da339298d4cc33efa00820894191a41f08444b00498c9637a3d945a06249b46bfac567c3e5a649cab6bd734512edcd2d338b860092180d67468140d00490c4a089d25f9208208945b28d2426e954b077ae48a2bdb96566d1104012a3e1cc2810089a0092183451fa4b1281b224b1d0cea6871e3a556ebde52687d539e79e272b56b458c70d49b42ea5899c109298c8b433e90009208901c2a42b08444800498c1036435947a0a424cebdf00239fbec33e5cf7f5e59f039888f2f7b54468c18d1ebd989b65042126dc964b2e78124263bffccde3f0124d13f437a80401c0490c438a833a62d044a4aa29240f53abcf1883ee75cce31260243124dcc1a31e7134012a90908f8238024fae3476b08c44500498c8b3ce3da40a0a82416baccb4d0a4afbfee5a39e698a3ad5b4d44126d2871e68024520310f0470049f4c78fd610888b0092181779c6b581009258248b48a20d25ce1c90446a0002fe082089fef8d11a0271114012e322cfb83610282a89eee6342fbdf472c1fb115d00f7ffe2e7b2efbe1fb76e031b24d18612670e48223500017f0490447ffc680d81b80820897191675c1b0894bc275109e0c48913fbbc94b45c91341116926862d688399f0092484d40c01f0124d11f3f5a43202e0248625ce419d706022525514d526d4cf3d18f8e96f9f317c875d7df909db77bcfe2b66d5bad5b45549344126d2871e68024520310f0470049f4c78fd610888b0092181779c6b581405992a826ea3e0aa3baba3a3bef9d3b77ee228e364071e78024da94cde4ce05494c6eee9979300490c46038d20b04a2268024464d9cf16c2250b624da34e972e78224964b8ae374268024ea9c1d6233810092684296881102bb124012a90a0878278024166187247a2f2c5aea430049d427174462260124d1ccbc11350490446a0002de09208948a2f7eaa1a51104904423d244901a134012354e0ea141a008012491f280807702482292e8bd7a6869040124d1883411a4c60490448d934368104012a9010884420049441243292c3ad5870092a84f2e88c44c0248a29979236a08b092480d40c03b01241149f45e3db43482009268449a0852630248a2c6c9213408b092480d40201402154be2fdbff8b91c76d8a14e30f7dd77bf8c1a3552f6ddf7e3a13f2771ead443a4a1618aa453e92c88aeee2e59b97295b4b43ce5bc977fcc86d65659bc788967706c5ce3191d0d352280246a940c4231920092683bcfbc60000020004944415464da081a02c24a22450001ef042a92c4c7973d2abbef3e58eebceb6eb9f082f3e5a1871e96077ffd6bb9f5969be4bdf7b6cae18d47788fa444cbe9d38f94fdc68c91c7962d93b56b9fdfe5e871e3c6cab4c646d9b479b32386ae30aa63972e7dc4535c48a2276c34d28c0092a8594208c7380248a27129236008380490440a0102de09942d8933671c2f575e798523867ffad39fb2ff7de1dc8be4faebae95638e395ae6cdbb5c162f79c07b34455ace9c3943eaeaeaa4b9b9595a5b37ee7264a19f976a532a5024b114217e6e020124d1842c11a3ce0490449db3436c10e89b0092487540c03b01632471f6ec59ce2c172e5c5470b6857eae5613274e9c20cb973f5170f5b1143624b114217e6e020124d1842c11a3ce0490449db3436c104012a901088441a06c495483abfb11d5fd87b9979bbaab8acf3efbac9c78d22961c428f5f5a3a4a9a949060f1a94ed3ff77e44f7e76d6d6dbdee4154923879d224797acd9aec7d8b9504882456428b6375258024ea9a19e232850092684aa6881302bd09b092484540c03b818a24510da32e2d3df9e4137b8df8e4932b42134435907bbfe1d66d5bb32b89ea1e45f5bedab8e6b5d75e73241249f45e08b4b4970092686f6e9959340490c46838330a0482268024064d94fe9244a06249d4058ebb7ad8d9f9be2c5bf63892a84b6288433b0248a276292120c308208986258c7021f07f0490444a0102de09182b896acab9f72156724f627575b50c18d0bf24b54ca64bd2e9b45455953c34b003aa06a464c8a94364e8e8a181f54947c926b0e3e51db23db35ddebea72d72100307d64a474787747777453676e79819d253ff49498d9f1ed9980c643781ccfad552bdfa2ee9f7e673914e348ef327d2093218044226c039143260bab79a803a7faa46ec5ddfa3f32c0bdd5b987f1f6225bb9ba65229a92ac3fc944c663219e9e9890e4faa2625c3cf1c8e24ea5c9086c5b675fd5669ef6a974d0b36451e796d6dadb4b7b74b7777776463778f3f4152fb4c967e071d15d9980c6437819deb5689b4dc2e559b9f8974a2719c3f914e90c120103201cea19001d3bdd504d4f9539624ba8fc0504b8fc55eebd6ad0ffc7989b99796babb9b2a291c3e6c58f6b9893c27d1ea3a65723e0870b9a90f783485808870b929650001330970b9a99979236a3d085474b9a9dadd74e2c489bd9e87e8caa3daddf4d6db6e975b6fb949de7b6f6b68a2e8ee70dad9d999154417a55a716c689822e954da796b436b6bafdd4e2b45ceeea69512e3781d0920893a6685984c2280249a942d6285c007049044aa0102de09942d89ae0c3ef4d0c372e1dc8b7a8da8763c3de698a31d793cf8e083b3ffbd78c903de23d3a02592a8411208c1370124d137423a4838012431e105c0f48d2580241a9b3a02d780009258240948a206154a08be092089be11d241c2092089092f00a66f2c0124d1d8d411b80604ca9644156ba9cb4d4f3ce914e7987df7fdb89c73ee79b262458b0653f41e0292e89d1d2df5218024ea930b22319300926866de881a024822350001ef042a9244358cbab4f4e4934fec35e27df7ddef5c82aa04f1d39f6e90f9f317c875d7dfe03d2a4d5a22899a2482307c1140127de1a33104d8b8861a8080a1049044431347d85a10a85812b5883aa22090c48840334ca80490c450f1d2790208b09298802433452b09208956a69549454400492c021a498ca80a192654024862a878e93c010490c4042499295a490049b432ad4c2a22021549e2dc0b2f90b3cf3e53d443e6f35fdbb66deff5688c88e20f7518243154bc741e1101243122d00c632d0124d1dad43231cb092089962798e9854aa06c493cf4d0a9ce33105f7ae9e5ecf3101f7ffc09f9d39ffe24575e7985147a3446a89147d0399218016486089d0092183a6206b09c0092687982999eb50490446b53cbc4222050b624e63f27f1f1658fca9b6fbe296a4753b599cde1877fd68a1d4d7399238911542043844e00490c1d3103584e0049b43cc14ccf5a0248a2b5a965621110f02c896a27d3bdf6da4b0e6f3cc291c4638e399acb4d034858aa262523e78c94a1a38706d01b5d40400449a40a20e08f0092e88f1fad2110170124312ef28c6b0381b225514d56ad1eaa57be187ee94b33ad7936222b8936943573c8258024520f10f0470049f4c78fd610888b0092181779c6b581404592987b5fa2bacc5449e398319f909d3b775af36c4424d186b2660e48e2a7a47ac2e7290408044200490c04239d402072024862e4c819d022021549a245f32e6b2adc935816260ed29c002b899a2788f0b42780246a9f2202844041024822850101ef0490c422ec9044ef85454b7d082089fae48248cc2480249a9937a2860092480d40c03b818a2431778753f7d117aa031b9f91a8902289de0b8b96fa104012f5c905919849004934336f440d0124911a80807702154962eec6356a77d38913273a3b9aaa8d6bdc9d4ebd87a25f4b2451bf9c1051e50490c4ca99d10202b9049044ea010266124012cdcc1b51eb41a06c49cc5d457cf0d7bf965b6fb949de7b6f2b8fc008388f3c022360a074c72330a80108f8248024fa04487308c44400498c093cc35a41c09324ba979a3efbecb3a27639e53989c1d50292181c4b7afa07015612a90408f8238024fae3476b08c44500498c8b3ce3da40a06c49cc7dfcc5c68dafc9cc99c7671f7b917b19aa0d50dc3970b9a94dd94cee5c90c4e4e69e99074300490c8623bd40206a024862d4c419cf2602654ba29af4dc0b2f90b3cf3e53aaabab65ddbaf5cea5a64a1077df7db09c73ee79b262458b4d6cd8b8c6aa6c26773248627273cfcc8321802406c3915e2010350124316ae28c6713818a24d1a6899733175612cba1c431ba13401275cf10f1e94e0049d43d43c40781c20490442a0302de095424893c02c33be8725b724f62b9a438ae5c024862b9a4380e0285092089540604cc2480249a9937a2d683404592c82330c24f1a92183ee3a48d8024262de3cc3768024862d044e90f02d1104012a3e1cc287612285b127904463405802446c33949a3208949ca36730d830092180655fa8440f80490c4f0193382bd043c49228fc008af2090c4f0d826b5672431a99967de411140128322493f1088960092182d6f46b38b40d992c82330a2493c92180de7248d82242629dbcc350c0248621854e91302e1134012c367cc08f612285b1215021e81117e212089e1334eda084862d232ce7c83268024064d94fe20100d0124311ace8c6227818a24511704e3c68d95698d8df2e2ba75b274e923d9b0a64e3d441a1aa6483a9576dedbd0da2a8b172ff11c368fc0f08c8e861a114012354a06a11849004934326d040d014112290208782760a424ce9e3d4bf6a8db43fef2d7bf6625d115c74d9b373b62e80ae3dab5cff712c94a50218995d0e2585d092089ba6686b84c2180249a9229e284406f024822150101ef042a96c4fb7ff17339ecb0439d11efbbef7e19356aa4ecbbefc7e59c73cf93152b5abc475266cbe9d38f94fdc68c9174bfb4e40ae0cc9933a4aeae4e9a9b9ba5b575a3d35ba1f7ca1cc6390c49ac8416c7ea4a0049d43533c4650a0124d1944c11270490446a00024111a84812d5731277df7db0dc79d7dd72e105e7cb430f3d2c0ffefad772eb2d37c97bef6d95c31b8f082aae82fda8d5c1c993263997992a51ccbddc54ad2eaad7c2858bb26dd5f113274e90e5cb9f7084b2d217925829318ed7910092a8635688c9240248a249d92256087c40809544aa0102de09942d89b9cf49741f81a124f1c2b917c9f5d75d2bc71c73b4cc9b77b92c5ef280f7688ab4acaf1f254d4d4dd2d6d6266bd7aeed754f62eecf72ef4174a5f2e9356ba4a5e5a98ae342122b4646030d0920891a2685908c2280241a952e828540960092483140c03b01632431f7d2d14183062189de734ecb84114012139670a61b3801243170a474088148082089916066104b09942d896afeea7e4475ff61eee5a6eeaae2b3cf3e2b279e744a2898f25704f37737ad7425b1baba5a060ce85f32d64ca64bd2e9b45455953c34b003aa06a464c8a94364e8e8a181f54947c926b0e3e51db23db35ddebea72d72100307d64a474787747777453676e79819d253ff49498d9f1ed9980c643781ccfad552bdfa2ee9f7e673914e348ef327d2093218044226c039143260bab79a803a7faa46ec5ddf53ee2cd5a5a5279f7c62afc39f7c72456882a80652ab88fbd4d7170c714bdb16e73ec44aee494ca552525586f92999cc6432d2d353369e7231f6799c7a4ee2f033872389be49d2814b60ebfaadd2ded52e9b166c8a1c4a6d6dadb4b7b74b7777776463778f3f4152fb4c967e071d15d9980c6437819deb5689b4dc2e559b9f8974a2719c3f914e90c120103201cea19001d3bdd504d4f9539124ea40a3d07312d9dd5487cc10838e04b8dc54c7ac10934904b8dcd4a46c112b043e20c0e5a6540304bc13a8e87253efc304dbb29024f29cc46019d39b3d0490447b72c94ce2218024c6c39d5121e0970092e89720ed934cc01a49544954f72e36344c91742aede474436babe4ee765a69a2d9ddb452621caf23012451c7ac10934904904493b245ac106025911a804010048c94c420265e4e1f486239943846770248a2ee19223edd092089ba6788f8205098002b89540604bc13282a89871e3a556ebde52619366c58c911b66ddb1eea73124b0610c20148620850e93272024862e4c819d0320248a26509653a892180242626d54c340402255712737733bdefbefbe5c2b9178510869e5d22897ae685a82a23802456c68ba321904f0049a4262060260124d1ccbc11b51e044a4a626e988f2f7b54c68cf984f356d88fbdd0010f92a8431688c12f0124d12f41da279d009298f40a60fea61240124dcd1c71eb40a022497403cebf0c75ddbaf57278e3113acc27d01890c44071d2594c0490c498c033ac350490446b52c944124600494c58c2996ea0043c49626e04ae300e1a34987b1203484daa262523e78c94a1a38706d01b5d40400449a40a20e08f0092e88f1fad2110170124312ef28c6b03014f92c84a6278a94712c3639bd49e91c4a4669e79074500490c8a24fd40205a024862b4bc19cd2e02654b62be18724f623885802486c335c9bd228949ce3e730f820092180445fa8040f40490c4e89933a23d044a4aa2bbbbe9ce9d3b65fefc0572ddf537d833fb1233e19ec4c4a4daea89228956a797c9454000498c0032434020040248620850e9323104784e629154238989390fac9e289268757a995c040490c40820330404422080248600952e1343a0e44a6262481498289298e4ecdb337724d19e5c329378082089f170675408f8258024fa2548fb2413401259494c72fd2762ee486222d2cc2443248024860897ae21102201243144b8746d3d01241149b4bec8933e412431e915c0fcfd124012fd12a43d04e2218024c6c39d51ed2080242289765432b3e8930092487140c01f0124d11f3f5a43202e0248625ce419d7060248229268431d338722049044ca0302fe082089fef8d11a0271114012e322cfb83610401291441bea9839208959023d079c28e9d19f92ea099fa72e201008012431108c740281c8092089912367408b08208948a245e5cc540a11602591ba80803f0248a23f7eb486405c0490c4b8c833ae0d04904424d1863a660eac24b292c859101a01243134b4740c8150092089a1e2a573cb09208948a2e525cef45849a40620e08f0092e88f1fad2110170124312ef28c6b0301241149b4a18e99032b89ac247216844600490c0d2d1d432054024862a878e9dc7202482292687989333d5612a90108f8238024fae3476b08c44500498c8b3ce3da40004944126da863e6c04a222b899c05a111401243434bc71008950092182a5e3ab79c009288245a5ee24c8f95446a0002fe082089fef8d11a0271114012e322cfb83610401291441bea9839b092c84a226741680490c4d0d0d2310442258024868a97ce2d2780242289969738d36325911a80803f0248a23f7eb486405c0490c4b8c833ae0d04904424d1863a660eac24b292c859101a01243134b4740c8150092089a1e2a573cb09182589b367cf923deaf67052b275db36696e6e96d6d68dd9144d9d7a8834344c91742aedbcb7a1b555162f5ee23985353535d2d9d929dddddd9efba8b461aa262523e78c94a1a38756da94e3215090002b89140604fc114012fdf1a33504e2228024c6459e716d20608c242a41ecdf7f40560cd5bfd56be1c245ceff8f1b3756a63536caa6cd9b1d31748571eddae765e9d2473ce50a49f4848d469a114012354b08e118470049342e65040c01870092482140c03b0123245109e0e73ef75979f6d9e7a4a5e52967b64a02274e9c20cb973f214a0467ce9c21757575bd56170bbd57092a24b1125a1cab2b012451d7cc1097290490445332459c10e84d0049a42220e09d80119258687a4a12274f9a244faf59e38863feca622191ac1413925829318ed7910092a8635688c9240248a249d92256087c400049a41a20e09d809192585f3f4a9a9a9aa4b3f37de77253f7df6d6d6dbdee41cc17c94a3121899512e3781d0920893a6685984c2280249a942d62850092480d40200802c649a2bb794d577797ac5cb9ca59454412832805fab0950092686b669957540490c4a848330e048225c04a62b03ce92d59048c9344373db91bd3bcf0c20bceca62b92b89d5d5d5326040ff9299ce64ba249d4e4b5555c943033ba06a404a869c3a84dd4d03234a473b5ede21db33dbe5ed7bda2287317060ad747474487777576463778e99213df59f94d4f8e9918dc9407613c8ac5f2dd5abef927e6f3e17e944e3387f229d2083412064029c432103a67bab09a8f3a76ac4def53d26ce32f73ec44aee494ca552525586f92999cc6432d2d3131d1ef5088ce1670e47124d2c484d63deba7eabb477b5cba6059b228fb0b6b656dadbdb237d8c4cf7f81324b5cf64e977d05191cf9701ed24b073dd2a9196dba56af333914e308ef327d2093218044226c039143260bab79a803a7fb497c4beee2dcc15437637b5ba4e999c0f025c6eea031e4d2120225c6e4a1940c04c025c6e6a66de885a0f02465c6eeade73a8903537374b6beb46993efd48e7d988ee7d893c27518f82220afd082089fae58488cc2280249a952fa285804b0049a41620e09d801192a8a6e78ae2e041839cd9e66e5ce34edfbd4f319d4a3b6f6d686dedb5db69a598d8ddb452621caf23012451c7ac10934904904493b245ac10f8800092483540c03b016324d1fb14bdb74412bdb3a3a53e0490447d72412466124012cdcc1b51430049a40620e09d009258841d92e8bdb068a90f0124519f5c10899904904433f346d4104012a90108782780242289deab8796461040128d4813416a4c0049d4383984068122049044ca0302de09208948a2f7eaa1a51104904423d244901a134012354e0ea1410049a40620100a012411490ca5b0e8541f0248a23eb920123309208966e68da821c04a22350001ef04904424d17bf5d0d2080248a2116922488d0920891a2787d020c04a22350081500820894862288545a7fa104012f5c905919849004934336f440d015612a90108782780242289deab8796461040128d4813416a4c0049d438398406015612a9010884420049441243292c3ad5870092a84f2e88c44c0248a29979236a08b092480d40c03b01241149f45e3db43482009268449a0852630248a2c6c9213408b092480d40201402482292184a61d1a93e0490447d72412466124012cdcc1b51438095446a0002de09208948a2f7eaa1a51104904423d244901a134012354e0ea1418095446a0002a110401291c4500a8b4ef5218024ea930b22319300926866de881a02ac24520310f04e00494412bd570f2d8d2080241a912682d4980092a87172080d02ac2452031008850092882486525874aa0f0124519f5c10899904904433f346d4106025911a80807702482292e8bd7a6869040124d1883411a4c60490448d934368106025911a804028049044243194c2a2537d082089fae48248cc2480249a9937a286002b89d40004bc1340129144efd5434b2308208946a48920352680246a9c1c4283002b89d40004422180242289a114169dea430049d427174462260124d1ccbc1135045849a40620e09d009288247aaf1e5a1a41004934224d04a931012451e3e4101a045849a40620100a012411490ca5b0e8541f0248a23eb920123309208966e68da821c04a22350001ef04904424d17bf5d0d2080248a2116922488d0920891a2787d020c04a22350081500820894862288545a7fa104012f5c905919849004934336f440d015612a90108782780242289deab8796461040128d4813416a4c0049d438398406015612a9010884420049441243292c3ad5870092a84f2e88c44c0248a29979236a08b092480d40c03b01241149f45e3db43482009268449a0852630248a2c6c9213408b092480d40201402482292184a61d1a93e0490447d72412466124012cdcc1b51438095446a0002de09182389e3c68d95698d8dd2bf7f7f67b69d9d9df2d8b265b276edf3d9d94f9d7a8834344c91742aedbcb7a1b555162f5ee2994e4d4d8d334e7777b7e73e2a6d98aa49c9c8392365e8e8a19536e5780814248024521810f0470049f4c78fd610888b0092181779c6b581801192e80ae2a6cd9bb3d23773e60c193e6c585614f38f71855149e4d2a58f78ca1592e8091b8d342380246a9610c2318e0092685cca0818020e01249142808077024648e2f4e947ca7e63c6f45a3974a5f0c575eb1c0954d258575727cdcdcdd2dabad12152e8bd4a50218995d0e2585d092089ba6686b84c2180249a9229e284406f024822150101ef048c90c442d3cb97c4d9b36739872d5cb8287bb85a4d9c3871822c5ffe44afcb52cbc58524964b8ae374268024ea9c1d6233810092684296881102bb124012a90a08782760ac24aad545258a2b57ae92d75e7b4d9a9a9aa4adadadd73d884a12274f9a244faf59232d2d4f554c0949ac18190d342480246a981442328a00926854ba08160259024822c50001ef048c9444f77ec3d75e7bdd91c2fafa5148a2f71aa0a5e5049044cb13ccf442278024868e980120100a01243114ac749a1002c649a22b88efbcf34ef6d2d24a25b1baba5a060cf8c72ea9c55e994c97a4d369a9aa2a7564703faf1a909221a70e6177d3e09026bea71d2fef90ed99edf2f63d6d91b31838b0563a3a3aa4bbbb2bb2b13bc7cc909efa4f4a6afcf4c8c66420bb0964d6af96ead57749bf379f8b74a2719c3f914e90c120103201cea19001d3bdd504d4f9533562effa1e1366594810ddb82bb92731954a495519e6a7643293c9484f4f7478d42330869f391c4934a1200d8971ebfaadd2ded52e9b166c8a3ce2dada5a696f6f8ff43132dde34f90d43e93a5df4147453e5f06b493c0ce75ab445a6e97aacdcf443ac138ce9f4827c86010089900e750c880e9de6a02eafc314212f32f31cdcf0abb9b5a5da74cce07012e37f5018fa61050cfe55db7527a56dc26f2c69a487970a95ca4b819cc42029c43162695294546c088cb4d0b3d27319f10cf498cac6618c8300248a26109235ced082089daa584802050160124b12c4c1c048182048c9044b54ab84f7d7dc1096c686dcdee68eaae36a65369e7d8dc9f79c93fbb9b7aa1461bdd082089ba6584784c2380249a9631e285c03f082089540204bc13304212bd4fcf5f4b24d11f3f5aeb410049d4230f44612e0124d1dcdc1179b2092089c9ce3fb3f74700492cc20f49f4575cb4d6830092a8471e88c25c0248a2b9b923f264134012939d7f66ef8f00928824faab205a6b4f0049d43e4504a839012451f304111e04fa208024521a10f04e00494412bd570f2d8d2080241a912682d4980092a87172080d0245082089940704bc1340129144efd5434b2308208946a48920352680246a9c1c42830092480d40201402482292184a61d1a93e0490447d72412466124012cdcc1b51438095446a0002de09208948a2f7eaa1a51104904423d244901a134012354e0ea1418095446a0002a110401291c4500a8b4ef5218024ea930b22319300926866de881a02ac24520310f04e00494412bd570f2d8d2080241a912682d4980092a87172080d02ac2452031008850092882486525874aa0f0124519f5c10899904904433f346d4106025911a80807702482292e8bd7a6869040124d1883411a4c60490448d934368106025911a804028049044243194c2a2537d082089fae48248cc2480249a9937a286002b89d40004bc1340129144efd5434b2308208946a48920352680246a9c1c4283002b89d40004422180242289a114169dea430049d427174462260124d1ccbc1135045849a40620e09d009288247aaf1e5a1a41004934224d04a931012451e3e4101a045849a40620100a012411490ca5b0e8541f0248a23eb920123309208966e68da821c04a22350001ef04904424d17bf5d0d2080248a2116922488d0920891a2787d020c04a22350081500820894862288545a7fa104012f5c905919849004934336f440d015612a90108782780242289deab8796461040128d4813416a4c0049d438398406015612a9010884420049441243292c3ad5870092a84f2e88c44c0248a29979236a08b092480d40c03b01241149f45e3db43482009268449a0852630248a2c6c9213408b092480d40201402482292184a61d1a93e0490447d72412466124012cdcc1b51438095446a0002de09208948a2f7eaa1a51104904423d244901a134012354e0ea1418095446a0002a110401291c4500a8b4ef5218024ea930b22319300926866de881a02ac24520310f04e00494412bd570f2d8d2080241a912682d4980092a87172080d02ac2452031008850092882486525874aa0f0124519f5c10899904904433f346d4106025911a80807702464ae2cc99334405be70e1a25e339f3af51069689822e954da797f436bab2c5ebcc4339d9a9a1ae9ecec94eeee6ecf7d54da30559392917346cad0d1432b6dcaf11028480049a43020e08f0092e88f1fad2110170124312ef28c6b0301e3245109e23ef5f5b2a56d4b2f491c376eac4c6b6c944d9b373b62e80ae3dab5cfcbd2a58f78ca1592e8091b8d342380246a9610c2318e0092685cca0818020e0124914280807702c648627dfd28696a6a9281037793ae4c976cddb6b597242a79acabab93e6e666696ddde81029f45e25a890c44a6871acae0490445d33435ca61040124dc9147142a0370124918a80807702c648e2f4e947cae8d1a31d096c6c3cdc9971eee5a6b367cfdae53db59a3871e20459befc09512b8a95be90c44a8971bc8e0490441db3424c261140124dca16b142e003024822d50001ef048c91c4dc29e60ba1bbcad8d6d6d6eb1e4425899385a8ea3b0000200049444154274d92a7d7ac919696a72aa68424568c8c061a124012354c0a2119450049342a5d040b812c01249162808077024862117648a2f7c2a2a53e0490447d72412466124012cdcc1b51430049a40620e09d402225b1baba5a060ce85f925a26d325e9745aaaaa4a1e1ad80155035232e4d421ec6e1a18513adaf1f20ed99ed92e6fdfd316398c81036ba5a3a343babbbb221bbb73cc0ce9a9ffa4a4c64f8f6c4c06b29b4066fd6aa95e7d97f47bf3b948271ac7f913e904190c022113e01c0a1930dd5b4d409d3f5523f6aeef31699685ee3face49ec4542a255565989f92c94c26233d3dd1e1518fc0187ee67024d1a482d43cd6adebb74a7b57bb6c5ab029f2486b6b6ba5bdbd3dd2c7c8748f3f4152fb4c967e071d15f97c19d04e023bd7ad1269b95daa363f13e904e3387f229d2083412064029c432103a67bab09a8f3c70a49647753abeb94c9f920c0e5a63ee0d1140222c2e5a6940104cc24c0e5a666e68da8f52060c5e5a60a25cf49d4a3a088423f0248a27e392122b308208966e58b6821e0124012a905087827608d242a046a37d3868629924ea51d221b5a5b7bed765a292636aea99418c7eb480049d4312bc464120124d1a46c112b043e208024520d10f04ec04849f43eddca5a228995f1e2683d0920897ae685a8cc2180249a932b2285402e0124917a808077024862117648a2f7c2a2a53e0490447d72412466124012cdcc1b51430049a40620e09d009288247aaf1e5a1a41004934224d04a931012451e3e4101a048a104012290f08782780242289deab8796461040128d4813416a4c0049d4383984060124911a804028049044243194c2a2537d082089fae48248cc2480249a9937a286002b89d40004bc1340129144efd5434b2308208946a48920352680246a9c1c4283002b89d40004422180242289a114169dea430049d427174462260124d1ccbc1135045849a40620e09d009288247aaf1e5a1a41004934224d04a931012451e3e4101a045849a40620100a012411490ca5b0e8541f0248a23eb920123309208966e68da821c04a22350001ef04904424d17bf5d0d2080248a2116922488d0920891a2787d020c04a22350081500820894862288545a7fa104012f5c905919849004934336f440d015612a90108782780242289deab8796461040128d4813416a4c0049d438398406015612a9010884420049441243292c3ad5870092a84f2e88c44c0248a29979236a08b092480d40c03b01241149f45e3db43482009268449a0852630248a2c6c9213408b092480d40201402482292184a61d1a93e0490447d724124661248b224ee565525435355322495323379441d0b81ed3d3db2b9bb5bb677f7c432be3b282b89b1e26770c309208948a2e1254cf8a5082089a508f1730814279054493cbd76373976e06eb2ad5f3fd9dad54d9940a06c02ea8f0b437abae50fed1d72fdd6ed9229bb65b0072289c1f2a4b76411401291c464557c02678b242630e94c3950024994c4eb3e344826eeb9a78cdb638f4059d259b208bcfceebbf2f7bfff5d666e7947e25853441293556fcc365802482292186c45d19b76049044ed5242408611489a241ed6bf5a2e1f314c0efcc8470ccb14e1ea48e02f6f6d91bbded8240fb677441e1e9218397206b488009288245a54ce4ca510012491ba80803f024993c42b3e3448268d18211376dfdd1f385a4340445eede89057366e947f6d7b37721e4862e4c819d0220248229268513933152451a4e78013253dfa53523de1f31404040221903449fcefa143a4ffb0e1b27fedc040f8d149b209bc9dc9c8eb1b36c817b6bc23eff7447bd1299298ecda63f6fe08208948a2bf0aa2b5f6045849d43e4504a83981a449e2ef870e917e48a2e655694e78ae241ebbe51de94012cd491c91269e0092882426fe24b01d0092687b86995fd80490c4b009d3bfcd0490449bb3cbdc6c268024228936d73773131124913280803f0248a23f7eb44e3681244be298744a8ea8ae96c6ea74b28b80d9574ce099ae6e59b533238fedcc4857c5ad836980242289c15412bd684b0049d436350466080124d1904411a69604922889e9aa2af9fa806a9931b846fe3e202dfd52555ae686a03426d023d2b9b34bdedeb653bebbbd5dde8ef8526d4506494412353e43082d080248621014e923c90490c424679fb9fb259044493ca67f3f397fe860d97bf7017ef1d13ee1045adfcfc88b6f6e9373b777482662164822921871c9315cd40490c4a889339e6d049044db32ca7ca224903449ec27228b060f94b1c306496d3a15256ac6b294c0936f6d973bded921ab33d15e786a95244e9d7a8834344c9174ea1fd77e6f686d95c58b97782e999a9a1ae9ecec94eeee6ecf7d54da30559392917346cad0d1432b6dcaf11028480049a43020e08f0092e88f1fad934d206992b867aa4aae183c500e1f3e38d98967f6811158f94ebbfcb66d87fcb27367607d96d3913592386edc5899d6d8289b366f76c4d015c6b56b9f97a54b1f2987c52ec720899eb0d148330248a26609211ce3082089c6a58c803522903449dc379592b307d7c8bf0cdf5da32c108ac904fef84ebb2851bcaba333d2695823893367ce90baba3a696e6e96d6d68d0ec442ef55421749ac8416c7ea4a0049d43533c4650a0124d1944c11a78e0490441db3424c261140127d666bf6ec594e0f0b172ecaf6a45613274e9c20cb973f216a45b1d217925829318ed7910092a8635688c9240248a249d92256dd082089ba6584784c238024fac8587dfd28696a6a92b6b6b65ef7202a499c3c69923cbd668db4b43c55f1084862c5c868a021012451c3a4109251049044a3d245b09a114012354b08e118470049f4913224d1073c9a5a4f0049b43ec54c3064024862c880e9de6a0248a2d5e96572111040127d40b64a12fb57c9870e1b2203d2d53e88d014021f10480d4acbf6b776c8bb7f7c27722ceaa6e7f6f60ee9ea8a70dbe68f364ad5c8032595d91ef97c19d04e023db57b4bf733f7896c5917e90463397f44e48cdadde4c08f7c44d6b677443a5f06b393c0a7060f923fbffebafc7447877446fc40f038cea1bd535532b3a6bf4c195aeb24f40fdbdeb733b1cc2a12029f193440d66fef94355bdf9787d8ddd41bf34aee49acaeae960103fa971ce8edb7df968103074a3aad9e7ac30b0210800004200001084000021080403208548dd8bbbec7f4a956b2bb692a9592aaaaaa9253aeaeee273b7766a427e2bf7c950c8c0320600881dd76db4dde7ffffd489f356a081ac2844049029c3f25117100048a12e01ca24020e09d803a7fac90c4309e9318c7650ade53494b08e847807348bf9c10913904387fccc91591ea49807348cfbc10951904ac794ea2c2ad76336d689822e954daa1bfa1b5b5d76ea795a6845f2e9512e37808f426c039444540c03b01ce1fefec680901458073883a808077025649a2770c855bf2cb2568a2f49734029c4349cb38f30d9200e74f9034e92b89043887929875e61c140124b108497eb9045566f49354029c4349cd3cf30e8200e74f1014e923c9043887929c7de6ee9700928824faad21da43a04f027c40531c10f04e80f3c73b3b5a424011e01ca20e20e09d009288247aaf1e5a42a004013ea02911087827c0f9e39d1d2d218024520310f04700494412fd5510ad21c039440d4020140248622858e9344104388712946ca61a380124912fb88117151d42c025c00734b50001ef04387fbcb3a325045849a40620e08f009258845f3a9d761e02ded3d3e38f32ad219050029c43094d3cd30e8400e74f2018e924c1043887129c7ca6ee9b803a7faa46ec5d8f05f9464907108000042000010840000210800004ec208024da91476601010840000210800004200001084020100248622018e9040210800004200001084000021080801d0490443bf2c82c200001084000021080000420000108044200490c04239d400002108000042000010840000210b083009268471ecb9ac5cc9933649ffafa3e8ffdcb5fff2a4b973e52565f951e347bf62ca7c9c2858b44c551575727cdcdcdd2dabab15757f5f5a3a4a9a949060f1ab4cb101b5a5b65f1e225150d5deeb815751ae0c1e3c68d95698d8df2e2ba75a1b10f305cbaca2150a856b76edbd6abaea74f3f52548e57ae5c252d2d4fedc2cfed43fd20f77c50ed0e3ce0805ec7173b3f9376de2830b9e73685691601f7f75efffefd0b069e7f1e0539bbdccf9f912347cae44993e4e9356b0a9e9f7d7d666e69dbe27c9699fee21c323d8395c55fea73c5fd1ce9ec7cbfcffa76fbc8fd3c2ae7b3303fd242b1b8c7747676ca63cb96c9dab5cf179d60fef7a762df2dcb21c5f7b15d292189e5548e25c7f83d8182c2508e24b6b5b5f51242f7e4ddba6d6b451fceba7f08f24b29a8aa8ab61f376f9b366fee55a7aade060f1a9cfd80732571c78e7679f2c92777f9d053e7c25e7bed29994c575612d57bc387fdfff6ce3c4e8ae2ece30fb0dccb728acb82880a08a811afc58308fa2a1a15410ef1081ae3110151b92f0fe43ec50b2189c7abc403056f4d0c081a15c424721801f15a0411168802cbb5bb2ceffb543e35e9eded99ee999d656667bff317ccf654577dabaaab7efd1c95596c913cf7dc73243bfb2cd9bcf907cf17257691ae28f306917864c77bbcef962ccf3d9d577e22d1fd4233d6b528de0ce3515eb2af8ff1682365fc87409075c5ae236969552437777b89b546c77ec78e1da556ad9a662d53a342d0b5d04b249ed8ba75203118b40f4bbbc74d96e752d0f61e89eb108947827292dca3b413285ecd884524eabded46d93e9c82d427d917411e4a417a31f9ae51f1e7b5c0b9fbd35ef7d3cf3f4b6e6e6e316bb12ec8175e78811188b56ad53222513f6a49778b3dbbc8fb59e0bd7e978af30691987c73229a1a25cb732f1691e83717a3e190e86b937d7d4c349f54b97fb89788eeb16cd79f7dfbf6890ac5254b9616f3f6d2f5ac71e3c652bf5ebd90f753d0b51091583e471322b17cf65b4cb50e2a1275e148ab922695ab5409b97daaabe7962d5b8c35a34ae52a72a8e85031173a2fd701a77b6850b7cf480f33af8da1dbcdc1eda6e075df35abd7c82f4efd45898db8fb61e76e93b33dbab968dffe54d9bd7b8f1cddb8b158f728fb90b5eeb2eefab8ddacb6e5e6167be0c6d4b1fce88813f07323b515b2634add899b1f738cfc75d1a2d0a2ab7fcbca6a2279797b43eed776fc4472f7f16a6cb4f3c6cea5860d1a9ae2dcf339dc7c5551ab1fa7ab9d7ba36d45a93e27f4e374cd8b75deb8ebabf3ade8d021293c54189567c1111f28dcd09340509168c7d68e9d3b24ab499629cb3e53752db2e3d739c6bc5cdf9ccfe168dd4dbd5ecc78ada57eeb85db62e99c373ffffcb3093bd8b479b31cd3ac9958375c778885dbfdd5f977bfb5903954712763103752a5e35c47d2d36bcb962d3f865e6ceadfba5c7cb17cbf699379416a436482ae85b18ac4487b4b3f7753bf39c17ecc7f4e2012fd19a5cc15d188445d7cadcfb99da4ce3811dd4456ab56dd583fbce23af45ecd9a350d09c9788944671bd2d3d3cdc2ea74f973bb5484bb6f76767609973ef7b54e973fb74b85dd08ebe26e37cc5e6e17cefae4e5e5192b911500ce075859c683a6cc004ea286b8179f70314a56242e5bbe5c4e6bdf5ed6ae5b178a7dd2f1a68b70464646b1185de7a2e8166fe110f88944e7bcf112a2ee853edcbc69d3a64d89184b67d9eebfbb3727b1cc1bf51c70cf6bbb594e95d8b0241ada47a42ad188441583eaaeedb4b4eb4b38fbcc745bcaddd631b77b686945a296d7b9732759b56a75682ebbd73bb77bb897c5d24b242a7c1b8be59e93e1eea1f363f3e6cdbe6b2173e8880ceda4bd499075c5b98eecdebddbbcc4b4fb1b1dafeddab69595ab56c9b9e79c13128941d7c25844a2d7bc71ce03fb72c50ad668f687ecc7820d554462304e297155a4c435e104a02696f15ad0fd04a77b72978548d40d698b162d8a25fc706f96c3ddd70a4cfb7071b671fdfaf546cce5e4e414730f745a1aebd5ab67acaa4ed757fd7ba4fae843d7eda2188b2b604a0cc61469849f05dd3966dab56b675aadc9976c6c87c629eaf76e6b859f35c48d2f1a91a82f75d40afefefb1f148b9174ce9570f3c60a4cebd6ea35dfd432ea4c30e57c16e8efa39d376bd7ae2d91dc29e89bf114196629d70cbfc435e104a08270af3d410467b8f11c6be21aad87ad63b8b9e72746bd44a2f385a7d79ae4e54eae75f15b7b9843293785626a90dfbae21ccb3a6634fed0c6d2eb78d68fd758b263d09d6c2d52b2c170896bfc5e8c7acd1b2f91e8b73f643f166c08211283714a89abfc849d6d64b837b1ce0c9c5e65b9177ee7642f0b91a8d6c070d95aedc329d27d9d7f736ee695835a28bd32ef59b72515896ef7a148225ceba39f704910c86e5afea7989765d8fd6241dfc4aacba92e60f62d6d9079e965cd77128b4624eabddd8bb92dcb5ae622cd9b709b5fb56684cb4c6c9f057a9f68e78dbab97b2517219eaafcce9920c24e5b17ce92e07c8e862bcbfd3cb663db4fbc39a9869b9b3af6740dd0acc56e6b86fdbd75add697315eeb45a4cdae96e16c97b514865b27fcd61ee650f99d2b655973f7bae27e0968bd5df4c5b9ba9aaa274cb8f1eeb51e392dfeee76848b65f46a6fb8bd65244ba2dffe90fd58b09185480cc62925ae0ab219d586462b12f56dac8d55b4e2acac2c895a376ba970babcba8fd2f012bceef63b1f525a7f5b6e10eb9ed7e6c5af3e918435223125a65828a6c3ba143bc798bab7d885b675eb56a1788fa0f33252ec879f4874ce1bb7db9917f94822d139f6b3b2b2446357d425295c963b67f9b1cc9b70c9451089e577ce94a548d471a1e112ce38c4d25812bd6212830838f70ba2203189ce7520c83d9ceb9c0dfff05a0b9943e577ae9475cd9deb8a7dd1672dd6366e7ec386af8caba9bee0747b6185ab9f9fb7471091e88c6ff7da5b4612891a3f1f694eb01f0b36b21089c138a5c4554137a3d18a447d63e35e4883c638853b27315c9646e7425bdacdae5d84352942a3868d426765c5bad9f5ab8fd7433188204d89c197428df05bfcc259a86d6c5d8d1a354c3653a71b8f9d3f5e317f4ecb44b874fd9144a27b831824d140249168efa519f09c59eefcb844b20cb98ffc700e172f4111e45e2934e452ae29652512bd2c6eeeb1120f4b62105750bffb38e7a1977526c83decc0f05b7b9843293785a26a50a467be737d708b441b16a1cffa03070e844225ecd9ce3634275ca2b5482ff2828844af3d6ba479e3bcde2bef84131afbb160430891188c534a5c559622d1b9c9b3c247a1d943c44beb6eea4e3ea0657b7d1729898157fbad9b8efbf066fdde9978c75a582325ebf1ab8ffb814ae29af23badac9b8e3be6c24b9039e350edef9c09579ce35289a8cb66f56ad54a9c1f1569c10d2712bdc6a4bd56efa5c9409c71c73626ca6fbeda76b8b3f7daef9d89989c1b582fb73bbf79a36771b937c176de92b8a67ccea1b21689ced83e6b598ca7bba97b2d71af17eec435ee316ee7a09e3717ce65d5cdc83d07dcf163ba71779e23ec5e0b9943e573aec4a3d676acf8ad2bee75c43d4e972d5b5e224745d0b5d0dd8ea02231d2de3248e29a707382fd58b09185480cc62925ae8a14b7a00df48ae3738ab14831897621d6eb35fe48ad26ba390ebae9b480bd02abeddfbc82a0bd12203837a87e9b5df762eeec68372fa7900ce7bee3571f77fb3802a3fc4e2dafbef6124d4e91e8b5398ef4f2c2492752128068e78dd7f5d11c59e325ec6c5ddd09099c4c629d375ab6733e720446f99d37ce35c52bee5bffee17fb1d2926d1e9a2a665a938d45002bbd974268a8a35718dfba5a2dec73deebd5e20398f90cac9d9688ebbf8e7679f79c679857b5638e3f09df7f05b7b9843e57bcec4a3f65e7b40af63549c9e5ceef5c96b5c06590b631189f6e5bcf3a826e7ded29d44275c5d9dcf19e7fe90fd98ffa84224fa33e20a08400002108000042000010840000215860022b1c274350d850004200001084000021080000420e04f0091e8cf882b20000108400002108000042000010854180288c40ad3d534140210800004200001084000021080803f0144a23f23ae80000420000108400002108000042050610820122b4c57d350084000021080000420000108400002fe041089fe8cb80202108000042000010840000210804085218048ac305d4d43210001084000021080000420000108f8134024fa33e20a08400002108000042000010840000215860022b1c274350d850004200001084000021080000420e04f0091e8cf882b20000108400002108000042000010854180288c40ad3d534140210800004200001084000021080803f0144a23f23ae80000420000108400002108000042050610820122b4c57d350084000021080000420000108400002fe041089fe8cb80202108000042000010840000210804085218048ac305d4d43210001084000021080000420000108f8134024fa33e20a084000021080802f81f3ce3b571e79789664666686aeddba75abdc79d720f9f8e365a1ef860e192c393939b260e12bbe65ea055a6e972e17cbfdf73f10e87a2e8200042000010894960022b1b404f93d0420000108547802bd7af690891327c8aa55aba4cf35d785782c5db258b2b2b264cc987b8c289c317d9a74ed7a45e8ff7ee0acf0fcfaeb6f8a95ebf73bfe0e010840000210280d01446269e8f15b084000021080804858f167c5e39b6fbe2543870d4724325a2000010840a05c104024968b6ea292108000042090cc04d442d8ab570f993d7b8e4c9f31d3b3aa7acdb5d7f609fded8517e68784a3f37bbde0a38f3e96471e7dac98fbaa755d9d307e9c29e3820b2f0a95a5164bfb9ddbedb5a0a02062bd92992b75830004200081c410402426863b778500042000811422e016661b367c554cc4d9a6badd4d870d1d22b7dc72b33cf1c493217139ffc5e7a543876c23ec962d5f6e84a2d3ddd429086db9ceefdc7fd7f25ab63ca1446c640ae1a729108000042010670288c43803a5380840000210a8b804dcd64225a156411ba7182426d1291ca31589f7dc7b9f1195bb77eff114a915b7676839042000010844430091180d2dae850004200001080424e0b42e3a5d4bbd12d7d8d8c5f4f4daa674eb221aad48541754a750c5d53460677119042000010814238048644040000210800004ca8880158ad6b2e7e56e3a60403fa95ab56ac8e2581a4ba2334ed12952118b65d4c1140b010840204509201253b463691604200001081c19026e21e8beab3346d02d12bde2059d4970825812fdeecf311a47661c701708400002a9440091984abd495b2000010840202104ac8ba733fe502be24e4ce3febf8ac4f6eddb87ce4dd4bfab65513f3653aa57221a9bd84633a9da7b6bb21caf9844afe4380981c44d2100010840a0dc104024969baea2a2108000042090cc04dc71855ad7bcbcbd2101a8ff77ba805a41a922b075eb56a669ea16ba60c12ba2718bab56ad32096fac087496e5fc8d8a43fb517753af7ad898c864e647dd2000010840207908201293a72fa8090420000108400002108000042000818413402426bc0ba800042000010840000210800004200081e42180484c9ebea026108000042000010840000210800004124e009198f02ea002108000042000010840000210800004928700223179fa829a4000021080000420000108400002104838014462c2bb800a400002108000042000010840000210481e0288c4e4e90b6a02010840000210800004200001084020e104108909ef022a000108400002108000042000010840207908201293a72fa8090420000108400002108000042000818413402426bc0ba800042000010840000210800004200081e42180484c9ebea026108000042000010840000210800004124e009198f02ea002108000042000010840000210800004928700223179fa829a4000021080000420000108400002104838014462c2bb800a400002108000042000010840000210481e0288c4e4e90b6a02010840000210800004200001084020e104108909ef022a000108400002108000042000010840207908201293a72fa8090420000108400002108000042000818413402426bc0ba800042000010840000210800004200081e42180484c9ebea026108000042000010840000210800004124e009198f02ea002108000042000010840000210800004928700223179fa829a4000021080000420000108400002104838014462c2bb800a400002108000042000010840000210481e0288c4e4e90b6a02010840000210800004200001084020e104108909ef022a00010854540295d22a49ad136b49f5acea929651550ee71f9283dbf3e5c07707247f5b7ea9b13469d244468e18269d3a7592060dea4b952a55243f3f5fbefdf65b79e2c9a7e48517e697fa1e8928a057cf1e3271e204d9b2658b5c70e145655e85f3ce3b571e79789664666696b8d7a1438764f7eeddf2de7b4b64cc3df74a5edede52d7e7c20b3acb7df7dd2bc71f7f9ce9b3e5cb3f915ebdfb94ba5c0a80000420000108042580480c4a8aeb20000108c491409d3332a45ec7ba5239ad92a4d5ac2669d52acbe12291fcbd0552547448f67fb35f7e5afa9314ee2a8ce9ae975cd245c68f7b40b2b29ac8b66ddb64e5aad572e0c0016973626b69d5aa95a8b8f9fd1ffe2853a74e8fa9fc44fe285122b151a3469293b3510a0afe2be0ab57af2ec71c738ca4a5a5c91b6fbc29fd070c2c359a8766cd945ebd7aca86afbe92cf3fff977cf9e597f2f8e3734b5d2e0540000210800004821240240625c57510800004e244a0419786927e726d496f942e35326a9428b5f060a1e4e5e649c1be02d9b62057f27f3c18d59d5bb76e2573e73e2e2d4f38415e7fe34d19356a74310bd71d03facbc08177486161818c1e73afbcfefa1b51955fd12eb696c4f4f43a3266cc3db260e12bc510dcfcdb9b64e4c8e1b277ef3e193c78882c59fa7ea910cd7ff179e9d0215b66cf9e23d367cc2c5559fc18021080000420100b0144622cd4f80d042000811809a8f5b06e877a9291952155ab578d584ade8e3db22f77bffcf0c416399c5f14f88ea3478f94dfdd76abac5fffa5f4ecd5dbd305f299ff7d4a3a74e8204f3df5b44c9b3e43ce39e76c193d6aa4b46ddb466ad6ac29870f1f36bf5bb478714864ce983e4d7af5ea212f2f5828e79cdd415ab46821454545f2af2fbe902953a649d7ae5748b72bbb4aeddab565d7ae5df2d2cb0b64ecd871a6de2a7cdab76f2f2fce9f2f575ed9558e6ad4c8b8be7efae9dfcdfd3ffb6ca5b94e05ee3d63464b7676b6a4a7d7964a952ac9fefdfbcd75631f18271b367c255e96c49e3dae92fe03fa49ab962da572e5ca92939323cb3f5921bd7bf594050b5e91a1c38617ab43d72b2e97c68d1b9bfa6fdcb8510e6ff6c500000db8494441541e7ae81159f8caab9e8cfd44a2d6f3edb7de34eea856449e7efa69327cd850c9ce3e4bd4da78f0e041f9e28bb53269f214e33eea64b262c50a39fffc5f9a7a171414488d1aff7d71a07da065fee5dd7765e890c1d2ad7b37c34e3fdb77ec905716be2ae3274c34ffb75c366cd8206af56cd6aca9e4e6e6ca575f7d2d679fdd21a67e8ba63f3effd7e7927f30dfdc4bdbbc77ef5e79f7af8b8abda4b0e3eca493da85e5d2b95327193e62a89cd4ae9db1d06a399f7cb242264c9c64fa9f0f0420000108943d014462d933e60e108000040c816a8daa4ae68d4da44ee33a52bd76f54054fe9df36fd9f5cf5dc6f534e8e7f5d75e91f6ed4f95279f7c5ac68d9fe0fb3315024f3df947e336b96edd7af972c306c96ad2c494a19bfd79f39e33f1762a12fbf4e96d84ccce9d3b65e5ca55d2a64d1b133ba762242323c388b94345457276876c2334274e9a22cf3cf3ac11682a10d4cdf5c7ad5b65f5aad572d2492799dfea3d7f777b7fc9cddd267f9af7ac9c79e619f2f5d7df18f159273d5dce3aeb4c53f6e2c5efc96f6ebab98448d418be69d3a6c851471d65cadafcc30fd221fb2c494f4f372263fefc97432251eb50585828df7fbf49d6ad5b276ddbb695962d4f906fbffdce94adf19aee8f9f48544138e7f1d952b76e868c1a354672b76f979933a64b932699219e27b66e6d04f8f6eddb65f8f091c6daa84cb46c15cb2a82aad7a82e878b0e9b76b46871acf92e67e346993fff25b9f186be72d555dd65cf9e3d46fc6abf649f7596d4ac59435e7df535b9ebeec1212eb56ad5941f7ed8226bd6ac317da06ec63d7a5c1575bf2d5cb830aafe484bab22050585f2f77ffcc320d4fad5a851ddb8354f9a34456c3fa998d6fe75f2b763203bfb4cf392a056ad5af2d9ca95b275eb3639f9a4934c1fad5fbfdeb8f322147da73417400002102835014462a9115200042000816004ea77ae27f5b2eb4bfde6f583fd40440ee61d943db97be4fb8737891c3aecfb3b6bd5528172dffd63e5c5175ff2fdcd80fefd64e0c001b27af51ae973cd75a1ebad4552c58a7eaf22f1da6bfb181179fbedfdcd66fde28b2f32dfab409afbfb3f188ba27ee63cfe98b12c3ef7fc0b3262c42823883a763ccf0803bbd1d7baaa283cedb4f64648ac59f3b98c1fff80ecdcb1436efb5dff9060bbf1c61b64cce89146f868a21ab725f1d9679e96ce9d3b85c492dedf0a124ddea3097aac2551ebf0f1c7cbe4b737df622ca55a8737de784d9a6635f57425d5b2228944bdcf9d770e34c25663076fbdad9f0c197cb75c7ef96532ef4fcfc9bdf7de1fe279ff7df7c84d37fd46de7efb1d1970c79d21266fbff367b9edb6db43d7b9dd4dafeade4d264e1c6fc4ded0a1c343eeacca77c2f8714608aa9b6b83060d4c429f83070f18b1aae5ea27d67efbf0c38fa2ea8fc3878b64d2e4a9f2ecb3f3cc7d870d1d220306f493152b3e35e367f6638f182bb2b6fff67e03cc35760ce88b8a993367196ea79c72b23c38eb219933e7f7212673e7cc964b2fbd44fef0c7278ce0e4030108400002654b009158b67c291d021080408840d35bb224e3b8ba52b36ecdc0540e1f16d999b3437217e6ca819c03bebff3b37af916e0b8c08a31b5e074ebde2324365e7e7981dc3d6888b9d2de4f5d25d59af5b7bf7d68be1f317ca8f4eb777b31574faf383b2b24962d5b2ed75ddfd7b37af61e2a92fade70939c7e5afb5076d341838698f84b75915521b868d1e250199a00a677ef5ec544a2d661ce9cb93275da8cb0a2cc5d8948d94dedb53b76ec94c953a6c85b6fbd6d5c4f55a47ff0b70f65dfbe7da1e2d26bd7960b2ee82c1b377e6fc46eb8d843f7f713278c971b6ef8b529bb5fff3b8a554f0572a74ee71babf1dab56b3db3be5a91184bbf797548b8fed8ba75ab5c7e45d7907bb35bccbfb7f85d69dab4997979f1d24b2f97285a5d6e1f7ee84163fdd5715478e850e89acca38f366eacf6854534e3986b2100010840207a0288c4e899f10b084000023111687e7773c9689a21d56a568beaf7fffe6ea7ec58b453f2d6e405faddd2258ba569d3acc096445b68fb534f955ffeb2a3b46bd7565ab56a29cd9b3737f1856a31545163c586b5cc3945a2fefbcebb06192b9d7eacf873c703ba13bf78c517aa55a9d3f9e7cbc9a79c6cdc0c8f6bd1c2b89b6a9656bd4793cccc9018ba7fec034658ecdebda798400957072fa1ea9728c68a22afeca67bf6e49918c3d75e7fdd700a22287ffcf14763491c3ce86ecf0435eefa28f7debd7b7aba0f3bfbe4934f3e89281263e937e5184d7f388f2471f6edc851a38d2551634c9de3c439a0edf56a5d0cf7d11716ff73d12581e60117410002108040ec041089b1b3e39710800004a22270a444a28a0cb5ba448a49bcefde7be4baebae910f3ffa58a64f9f6162e8d4ed5337f11a2397979767e2c14e38e1f890e5ab2c45e2e6cd9b8cb572f6638f1ad751b52669eca0262dd1f3109b356b66feed16899a0846ebf5f3cf3f97b9480c97ddd43908ac48748b66af8112d49298289138f68107a2ee8f7022f19e7bef33674d46e272a48f36896af27231042000810a46009158c13a9ce642000289231093bba988ecfc2eb8bba9b6ce2fbba98d033be38cd3e5b9e79e3740aebffe3a938866f294a9a1ec9b37dd74a3c978ba79f30f71b1246adcdecc0767153bf3cf5a1c972e7ddf64381d34e82e230a274e9c2c7ffecbbba66e36ee518fec708bc448eea62a7c35d18ec665da98c4d258128388c4e38f3f5ee63dfbb4c99caa02f6e9a79f093be0828a443f775375d35417da6fbef936ae9644cdfa1a6d7f841389fa7d3877d3a953279b38534de6a3c96ef4e3761d4edcace5ce108000042a26014462c5ec775a0d01082480c091485ca3cdb2d94ad55dd4eb9c44151d9a804633946a6ce19d03ef306e8fce583d15920f3e38532efbd5a5e6088578b89bba93c6685299a79f7ac2d477d6ac87e5d8638f35f572c6ce697b3499cd0d7d7f2d3b76ec282112b55e5e896b2c83e38e3bae444ca2fbfcc1a0eea64144a2d657dd2abb75bb5234ced226c8d1eff52cc5db6ebdc52408baaa47afc031897e896baa54a92cc3868d30aec19ab84645b653acc56a01d63ac7d21f766ab92d835e896bec999e594dfee31e7d4d9fab4d36dbd75e7f43060ebc2b344b1f7df461b9b2eb1526e98d263ee2030108400002654b009158b67c291d021080408840cc47607cb64b7e5a12fc080cbde135d75c2da3468e94860d1b9858be95ab564b417ebec91ca9e71bea510a9a8972debc3f898ac6be7daf37495654d8e8997ea79f7eba64661e6dceeed3e30ae225123513a73dfee0d4ff3fa6e39866cd4c1ce32db7de26bfb9f14663b95297574d50f2ef9f7e3267e5e93119fa9d1e1fe1b6246abd7e75e9253269d20493dd538f52f8eebbefe4dc73cf95060dea9bfa3bb39b96b52551d93b8f7af87ed32663213db67973d1b30195ade51ed492a8656adc65d02330e22512f5acc958fa239c48b45cd4caba76ed3af9fa9b6f448f0fd131a09954357151dfbebf96d1a346489d3a754cb6d875ebbf943627b69656ad5a153b3e84c70a0420000108942d014462d9f2a57408400002c508d4ed5857ea75a827194d32a46a8daa11e9e4edd823fb72f7cb0f4f6c91c3f9455193d40df8a0bbef3296193d33d01e4caf424a8f1b78ff830f4c996a359c3c79925cd2e562638dd258c04d9b3699c3e5fb5c7db539dc5d8f58b8ecb2cb8c652996042856102d59b2d4582debd6ad6b44a99e7d387ec224d1642efa193bf63ee9ddaba7f9bb1e74afd6c3975e5e207ac0ba8a453d77716f5e5e098b59cf1e57c9dd77df69ac912a0c55e0a805b44b978b8fb848d476b80f8d57a69ad574cedcb9a63efa8946246a1f0d1d3258ba75ef2647356a647eaf6753aa2bedb4e9ffc9d41a2ea62f564ba2ba7cc6da1fe1eae3e6a271a6effe75918c1a353a941555fbb27fffdba565cb962636556364d7ad5f2fd3a6ce088dd9a827033f800004200081a8082012a3c2c5c5108000044a4fa0419786927e4a6d496f982e35326a9428b0f060a1ecddbe57f2f7e6cbb605b992ffe3c1d2df34c125f8b9749645f5f4088ceeddbb9538f2a22cee459910800004200081542280484ca5dea42d108040b92150e78c0ca9d7b1ae544eab246935ab495ab5ca72b848247f6f8114151d92fddfec979f96fe2485bb0acb4d9b2255b42c45e23befbc29cd9a369571e326c88285af986ab863ddbccee54b09b034020210800004205006041089650095222100010804215029ad92d43ab19654cfaa2e691955e570fe2139b83d5f0e7c7740f2b7e50729a2dc5c539622d1c654eedab54b567cfa77137ba9995433333343f18e79797bcb0d2b2a0a0108400002104834014462a27b80fb43000210a80004ca52246abcde8811c3a57bb72ba57efdfa86e6eeddbb65f17b4b64f2e4a9a178c70a80992642000210800004e242009118178c14020108400002108000042000010840203508201253a31f6905042000010840000210800004200081b8104024c6052385400002108000042000010840000210480d0288c4d4e8475a010108400002108000042000010840202e04108971c14821108000042000010840000210800004528300223135fa9156400002108000042000010840000210880b0144625c305208042000010840000210800004200081d42080484c8d7ea415108000042000010840000210800004e242009118178c14020108400002108000042000010840203508201253a31f6905042000010840000210800004200081b8104024c6052385400002108000042000010840000210480d0288c4d4e8475a010108400002108000042000010840202e04108971c148211080000420000108400002108000045283c0ff01f20bb4a5b78725b60000000049454e44ae426082');


--
-- Data for Name: tbl_queued_click_through_records; Type: TABLE DATA; Schema: queueing; Owner: bulkmail_user
--

INSERT INTO queueing.tbl_queued_click_through_records VALUES (1, 1, 90, 1, '2025-08-27 02:11:47.570457');


--
-- Data for Name: tbl_queued_click_throughs; Type: TABLE DATA; Schema: queueing; Owner: bulkmail_user
--

INSERT INTO queueing.tbl_queued_click_throughs VALUES (1, 10, 'https://blindza.com/', 'c9591432-7214-4344-a2ee-a41c146edae8');
INSERT INTO queueing.tbl_queued_click_throughs VALUES (2, 11, 'https://blindza.com/', '79cd7bca-8058-49a1-a011-a9598d1403b9');


--
-- Data for Name: tbl_queued_customers; Type: TABLE DATA; Schema: queueing; Owner: bulkmail_user
--

INSERT INTO queueing.tbl_queued_customers VALUES (68, 'garfield', 'cat', '0821112233', 'garfield.cat@blindza.xyz', 9, true, '', 'Mr', 38, '2025-08-27 01:34:34.649441');
INSERT INTO queueing.tbl_queued_customers VALUES (69, 'odie', 'dog', '0821112233', 'odie.dog@blindza.xyz', 9, true, '', 'Mr', 39, '2025-08-27 01:34:35.001264');
INSERT INTO queueing.tbl_queued_customers VALUES (70, 'john', 'lennon', '0821112233', 'john.lennon@blindza.xyz', 9, true, '', 'Mr', 40, '2025-08-27 01:34:35.304097');
INSERT INTO queueing.tbl_queued_customers VALUES (71, 'paul', 'mccartney', '0821112233', 'paul.mccartney@blindza.xyz', 9, true, '', 'Mr', 41, '2025-08-27 01:34:35.657367');
INSERT INTO queueing.tbl_queued_customers VALUES (72, 'ringo', 'starr', '0821112233', 'ringo.starr@blindza.xyz', 9, true, '', 'Mr', 42, '2025-08-27 01:34:36.107764');
INSERT INTO queueing.tbl_queued_customers VALUES (73, 'george', 'harrison', '0821112233', 'george.harrison@blindza.xyz', 9, true, '', 'Mr', 43, '2025-08-27 01:34:41.970508');
INSERT INTO queueing.tbl_queued_customers VALUES (74, 'tintin', 'journalist', '0821112233', 'tintin@blindza.xyz', 9, true, '', 'Mr', 44, '2025-08-27 01:34:42.378664');
INSERT INTO queueing.tbl_queued_customers VALUES (75, 'snowy', 'dog', '0821112233', 'snowy.dog@blindza.xyz', 9, true, '', 'Mr', 45, '2025-08-27 01:34:42.832192');
INSERT INTO queueing.tbl_queued_customers VALUES (76, 'captain', 'haddock', '0821112233', 'captain.haddock@blindza.xyz', 9, true, '', 'Mr', 46, '2025-08-27 01:34:43.351311');
INSERT INTO queueing.tbl_queued_customers VALUES (77, 'michael', 'ende', '0821112233', 'michael.ende@blindza.xyz', 9, true, '', 'Mr', 47, '2025-08-27 01:34:43.718149');
INSERT INTO queueing.tbl_queued_customers VALUES (78, 'stephen', 'king', '0821112233', 'stephen.king@blindza.xyz', 9, true, '', 'Mr', 48, '2025-08-27 01:34:52.830389');
INSERT INTO queueing.tbl_queued_customers VALUES (79, 'arthur.c', 'clarke', '0821112233', 'arthur.c.clarke@blindza.xyz', 9, true, '', 'Mr', 49, '2025-08-27 01:34:53.262011');
INSERT INTO queueing.tbl_queued_customers VALUES (80, 'isaac', 'asimov', '0821112233', 'isaac.asimov@blindza.xyz', 9, true, '', 'Mr', 50, '2025-08-27 01:34:53.709853');
INSERT INTO queueing.tbl_queued_customers VALUES (81, 'wilbur', 'smith', '0821112233', 'wilbur.smith@blindza.xyz', 9, true, '', 'Mr', 51, '2025-08-27 01:34:53.999537');
INSERT INTO queueing.tbl_queued_customers VALUES (53, 'george', 'harrison', '0821112233', 'george.harrison@blindza.xyz', 8, true, '', 'Mr', 43, '2025-08-27 01:25:47.83915');
INSERT INTO queueing.tbl_queued_customers VALUES (48, 'garfield', 'cat', '0821112233', 'garfield.cat@blindza.xyz', 8, true, '', 'Mr', 38, '2025-08-27 01:25:47.846905');
INSERT INTO queueing.tbl_queued_customers VALUES (54, 'tintin', 'journalist', '0821112233', 'tintin@blindza.xyz', 8, true, '', 'Mr', 44, '2025-08-27 01:25:49.120099');
INSERT INTO queueing.tbl_queued_customers VALUES (49, 'odie', 'dog', '0821112233', 'odie.dog@blindza.xyz', 8, true, '', 'Mr', 39, '2025-08-27 01:25:49.151181');
INSERT INTO queueing.tbl_queued_customers VALUES (55, 'snowy', 'dog', '0821112233', 'snowy.dog@blindza.xyz', 8, true, '', 'Mr', 45, '2025-08-27 01:25:50.037975');
INSERT INTO queueing.tbl_queued_customers VALUES (50, 'john', 'lennon', '0821112233', 'john.lennon@blindza.xyz', 8, true, '', 'Mr', 40, '2025-08-27 01:25:50.051219');
INSERT INTO queueing.tbl_queued_customers VALUES (56, 'captain', 'haddock', '0821112233', 'captain.haddock@blindza.xyz', 8, true, '', 'Mr', 46, '2025-08-27 01:25:50.507067');
INSERT INTO queueing.tbl_queued_customers VALUES (51, 'paul', 'mccartney', '0821112233', 'paul.mccartney@blindza.xyz', 8, true, '', 'Mr', 41, '2025-08-27 01:25:50.584595');
INSERT INTO queueing.tbl_queued_customers VALUES (57, 'michael', 'ende', '0821112233', 'michael.ende@blindza.xyz', 8, true, '', 'Mr', 47, '2025-08-27 01:25:50.776208');
INSERT INTO queueing.tbl_queued_customers VALUES (52, 'ringo', 'starr', '0821112233', 'ringo.starr@blindza.xyz', 8, true, '', 'Mr', 42, '2025-08-27 01:25:50.883529');
INSERT INTO queueing.tbl_queued_customers VALUES (58, 'stephen', 'king', '0821112233', 'stephen.king@blindza.xyz', 8, true, '', 'Mr', 48, '2025-08-27 01:25:57.542802');
INSERT INTO queueing.tbl_queued_customers VALUES (59, 'arthur.c', 'clarke', '0821112233', 'arthur.c.clarke@blindza.xyz', 8, true, '', 'Mr', 49, '2025-08-27 01:25:58.711435');
INSERT INTO queueing.tbl_queued_customers VALUES (60, 'isaac', 'asimov', '0821112233', 'isaac.asimov@blindza.xyz', 8, true, '', 'Mr', 50, '2025-08-27 01:26:03.223947');
INSERT INTO queueing.tbl_queued_customers VALUES (61, 'wilbur', 'smith', '0821112233', 'wilbur.smith@blindza.xyz', 8, true, '', 'Mr', 51, '2025-08-27 01:26:04.754488');
INSERT INTO queueing.tbl_queued_customers VALUES (62, 'george', 'lucas', '0821112233', 'george.lucas@blindza.xyz', 8, true, '', 'Mr', 52, '2025-08-27 01:26:05.316763');
INSERT INTO queueing.tbl_queued_customers VALUES (63, 'alan.dean', 'foster', '0821112233', 'alan.dean.foster@blindza.xyz', 8, true, '', 'Mr', 53, '2025-08-27 01:26:07.176427');
INSERT INTO queueing.tbl_queued_customers VALUES (64, 'andre', 'norton', '0821112233', 'andre.norton@blindza.xyz', 8, true, '', 'Mr', 54, '2025-08-27 01:26:07.458196');
INSERT INTO queueing.tbl_queued_customers VALUES (65, 'charles', 'dickens', '0821112233', 'charles.dickens@blindza.xyz', 8, true, '', 'Mr', 55, '2025-08-27 01:26:07.721372');
INSERT INTO queueing.tbl_queued_customers VALUES (66, 'j.k', 'rowling', '0821112233', 'j.k.rowling@blindza.xyz', 8, true, '', 'Mr', 56, '2025-08-27 01:26:07.98403');
INSERT INTO queueing.tbl_queued_customers VALUES (67, 'sun', 'tzu', '0821112233', 'sun.tzu@blindza.xyz', 8, true, '', 'Mr', 57, '2025-08-27 01:26:08.391824');
INSERT INTO queueing.tbl_queued_customers VALUES (82, 'george', 'lucas', '0821112233', 'george.lucas@blindza.xyz', 9, true, '', 'Mr', 52, '2025-08-27 01:34:54.332541');
INSERT INTO queueing.tbl_queued_customers VALUES (83, 'alan.dean', 'foster', '0821112233', 'alan.dean.foster@blindza.xyz', 9, true, '', 'Mr', 53, '2025-08-27 01:35:03.238698');
INSERT INTO queueing.tbl_queued_customers VALUES (84, 'andre', 'norton', '0821112233', 'andre.norton@blindza.xyz', 9, true, '', 'Mr', 54, '2025-08-27 01:35:03.871638');
INSERT INTO queueing.tbl_queued_customers VALUES (85, 'charles', 'dickens', '0821112233', 'charles.dickens@blindza.xyz', 9, true, '', 'Mr', 55, '2025-08-27 01:35:04.76264');
INSERT INTO queueing.tbl_queued_customers VALUES (86, 'j.k', 'rowling', '0821112233', 'j.k.rowling@blindza.xyz', 9, true, '', 'Mr', 56, '2025-08-27 01:35:05.485483');
INSERT INTO queueing.tbl_queued_customers VALUES (87, 'sun', 'tzu', '0821112233', 'sun.tzu@blindza.xyz', 9, true, '', 'Mr', 57, '2025-08-27 01:35:05.884631');
INSERT INTO queueing.tbl_queued_customers VALUES (88, 'garfield', 'cat', '0821112233', 'garfield.cat@blindza.xyz', 10, true, '', 'Mr', 38, '2025-08-27 02:10:27.604501');
INSERT INTO queueing.tbl_queued_customers VALUES (89, 'odie', 'dog', '0821112233', 'odie.dog@blindza.xyz', 10, true, '', 'Mr', 39, '2025-08-27 02:10:28.014959');
INSERT INTO queueing.tbl_queued_customers VALUES (90, 'john', 'lennon', '0821112233', 'john.lennon@blindza.xyz', 10, true, '', 'Mr', 40, '2025-08-27 02:10:28.49634');
INSERT INTO queueing.tbl_queued_customers VALUES (91, 'paul', 'mccartney', '0821112233', 'paul.mccartney@blindza.xyz', 10, true, '', 'Mr', 41, '2025-08-27 02:10:28.932315');
INSERT INTO queueing.tbl_queued_customers VALUES (92, 'ringo', 'starr', '0821112233', 'ringo.starr@blindza.xyz', 10, true, '', 'Mr', 42, '2025-08-27 02:10:29.527352');
INSERT INTO queueing.tbl_queued_customers VALUES (93, 'george', 'harrison', '0821112233', 'george.harrison@blindza.xyz', 10, true, '', 'Mr', 43, '2025-08-27 02:10:32.917451');
INSERT INTO queueing.tbl_queued_customers VALUES (94, 'tintin', 'journalist', '0821112233', 'tintin@blindza.xyz', 10, true, '', 'Mr', 44, '2025-08-27 02:10:33.632085');
INSERT INTO queueing.tbl_queued_customers VALUES (95, 'snowy', 'dog', '0821112233', 'snowy.dog@blindza.xyz', 10, true, '', 'Mr', 45, '2025-08-27 02:10:34.099134');
INSERT INTO queueing.tbl_queued_customers VALUES (96, 'captain', 'haddock', '0821112233', 'captain.haddock@blindza.xyz', 10, true, '', 'Mr', 46, '2025-08-27 02:10:34.930918');
INSERT INTO queueing.tbl_queued_customers VALUES (97, 'michael', 'ende', '0821112233', 'michael.ende@blindza.xyz', 10, true, '', 'Mr', 47, '2025-08-27 02:10:35.755498');
INSERT INTO queueing.tbl_queued_customers VALUES (98, 'stephen', 'king', '0821112233', 'stephen.king@blindza.xyz', 10, true, '', 'Mr', 48, '2025-08-27 02:10:42.945049');
INSERT INTO queueing.tbl_queued_customers VALUES (99, 'arthur.c', 'clarke', '0821112233', 'arthur.c.clarke@blindza.xyz', 10, true, '', 'Mr', 49, '2025-08-27 02:10:43.279212');
INSERT INTO queueing.tbl_queued_customers VALUES (100, 'isaac', 'asimov', '0821112233', 'isaac.asimov@blindza.xyz', 10, true, '', 'Mr', 50, '2025-08-27 02:10:43.686897');
INSERT INTO queueing.tbl_queued_customers VALUES (101, 'wilbur', 'smith', '0821112233', 'wilbur.smith@blindza.xyz', 10, true, '', 'Mr', 51, '2025-08-27 02:10:44.092676');
INSERT INTO queueing.tbl_queued_customers VALUES (102, 'george', 'lucas', '0821112233', 'george.lucas@blindza.xyz', 10, true, '', 'Mr', 52, '2025-08-27 02:10:44.474013');
INSERT INTO queueing.tbl_queued_customers VALUES (103, 'alan.dean', 'foster', '0821112233', 'alan.dean.foster@blindza.xyz', 10, true, '', 'Mr', 53, '2025-08-27 02:10:56.753826');
INSERT INTO queueing.tbl_queued_customers VALUES (104, 'andre', 'norton', '0821112233', 'andre.norton@blindza.xyz', 10, true, '', 'Mr', 54, '2025-08-27 02:10:57.087594');
INSERT INTO queueing.tbl_queued_customers VALUES (105, 'charles', 'dickens', '0821112233', 'charles.dickens@blindza.xyz', 10, true, '', 'Mr', 55, '2025-08-27 02:10:57.346362');
INSERT INTO queueing.tbl_queued_customers VALUES (106, 'j.k', 'rowling', '0821112233', 'j.k.rowling@blindza.xyz', 10, true, '', 'Mr', 56, '2025-08-27 02:10:57.73094');
INSERT INTO queueing.tbl_queued_customers VALUES (107, 'sun', 'tzu', '0821112233', 'sun.tzu@blindza.xyz', 10, true, '', 'Mr', 57, '2025-08-27 02:10:58.811599');
INSERT INTO queueing.tbl_queued_customers VALUES (108, 'garfield', 'cat', '0821112233', 'garfield.cat@blindza.xyz', 11, true, '', 'Mr', 38, '2025-08-27 12:21:48.733146');
INSERT INTO queueing.tbl_queued_customers VALUES (109, 'odie', 'dog', '0821112233', 'odie.dog@blindza.xyz', 11, true, '', 'Mr', 39, '2025-08-27 12:21:50.453534');
INSERT INTO queueing.tbl_queued_customers VALUES (110, 'john', 'lennon', '0821112233', 'john.lennon@blindza.xyz', 11, true, '', 'Mr', 40, '2025-08-27 12:21:50.708937');
INSERT INTO queueing.tbl_queued_customers VALUES (111, 'paul', 'mccartney', '0821112233', 'paul.mccartney@blindza.xyz', 11, true, '', 'Mr', 41, '2025-08-27 12:21:51.046032');
INSERT INTO queueing.tbl_queued_customers VALUES (112, 'ringo', 'starr', '0821112233', 'ringo.starr@blindza.xyz', 11, true, '', 'Mr', 42, '2025-08-27 12:21:51.709672');
INSERT INTO queueing.tbl_queued_customers VALUES (113, 'george', 'harrison', '0821112233', 'george.harrison@blindza.xyz', 11, true, '', 'Mr', 43, '2025-08-27 12:21:53.587104');
INSERT INTO queueing.tbl_queued_customers VALUES (114, 'tintin', 'journalist', '0821112233', 'tintin@blindza.xyz', 11, true, '', 'Mr', 44, '2025-08-27 12:21:53.875567');
INSERT INTO queueing.tbl_queued_customers VALUES (115, 'snowy', 'dog', '0821112233', 'snowy.dog@blindza.xyz', 11, true, '', 'Mr', 45, '2025-08-27 12:21:54.122496');
INSERT INTO queueing.tbl_queued_customers VALUES (116, 'captain', 'haddock', '0821112233', 'captain.haddock@blindza.xyz', 11, true, '', 'Mr', 46, '2025-08-27 12:21:54.406954');
INSERT INTO queueing.tbl_queued_customers VALUES (117, 'michael', 'ende', '0821112233', 'michael.ende@blindza.xyz', 11, true, '', 'Mr', 47, '2025-08-27 12:21:54.769766');
INSERT INTO queueing.tbl_queued_customers VALUES (118, 'stephen', 'king', '0821112233', 'stephen.king@blindza.xyz', 11, true, '', 'Mr', 48, '2025-08-27 12:22:06.611042');
INSERT INTO queueing.tbl_queued_customers VALUES (119, 'arthur.c', 'clarke', '0821112233', 'arthur.c.clarke@blindza.xyz', 11, true, '', 'Mr', 49, '2025-08-27 12:22:07.475655');
INSERT INTO queueing.tbl_queued_customers VALUES (120, 'isaac', 'asimov', '0821112233', 'isaac.asimov@blindza.xyz', 11, true, '', 'Mr', 50, '2025-08-27 12:22:08.140672');
INSERT INTO queueing.tbl_queued_customers VALUES (121, 'wilbur', 'smith', '0821112233', 'wilbur.smith@blindza.xyz', 11, true, '', 'Mr', 51, '2025-08-27 12:22:08.710554');
INSERT INTO queueing.tbl_queued_customers VALUES (122, 'george', 'lucas', '0821112233', 'george.lucas@blindza.xyz', 11, true, '', 'Mr', 52, '2025-08-27 12:22:09.187057');
INSERT INTO queueing.tbl_queued_customers VALUES (123, 'alan.dean', 'foster', '0821112233', 'alan.dean.foster@blindza.xyz', 11, true, '', 'Mr', 53, '2025-08-27 12:22:14.242431');
INSERT INTO queueing.tbl_queued_customers VALUES (124, 'andre', 'norton', '0821112233', 'andre.norton@blindza.xyz', 11, true, '', 'Mr', 54, '2025-08-27 12:22:14.76337');
INSERT INTO queueing.tbl_queued_customers VALUES (125, 'charles', 'dickens', '0821112233', 'charles.dickens@blindza.xyz', 11, true, '', 'Mr', 55, '2025-08-27 12:22:15.274583');
INSERT INTO queueing.tbl_queued_customers VALUES (126, 'j.k', 'rowling', '0821112233', 'j.k.rowling@blindza.xyz', 11, true, '', 'Mr', 56, '2025-08-27 12:22:16.276759');
INSERT INTO queueing.tbl_queued_customers VALUES (127, 'sun', 'tzu', '0821112233', 'sun.tzu@blindza.xyz', 11, true, '', 'Mr', 57, '2025-08-27 12:22:16.866841');


--
-- Data for Name: tbl_queued_emails; Type: TABLE DATA; Schema: queueing; Owner: bulkmail_user
--

INSERT INTO queueing.tbl_queued_emails VALUES (8, 'Please read and respond', '<h2 class=""><img src="data:image/jpeg;base64,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" data-filename="xl500_small.jpg" style="width: 400px;"></h2><h2 class="">Hello,&nbsp;||title||&nbsp;||full_names||</h2><p><br></p><p>We have the following number on record for you:</p><p>||mobile||</p><p><br></p><p><br></p>', 6, 4, '2025-08-01 00:00:00', 'rogerwilco@blindza.xyz', '', '54321', true, true, '2025-08-27 01:26:16.508293', 'total of 20 - 20 ''good'' and 0 ''bad''', 'rogerwilco@blindza.xyz', 'Roger-123', 'dev.blindza.com', 587, true, true, '2025-08-27 01:25:36.472512');
INSERT INTO queueing.tbl_queued_emails VALUES (9, 'Hello World', '<p>Hello, ||title||&nbsp;||full_names|| ||title||&nbsp;||full_names||&nbsp;</p><p><br></p><p><a href="https://blindza.com/" target="_blank">BlindZA</a></p><p><br></p><p><br></p>', 6, 6, '2025-08-20 01:31:00', 'rogerwilco@blindza.xyz', '', '999888777', true, true, '2025-08-27 01:35:11.278621', 'total of 20 - 20 ''good'' and 0 ''bad''', 'rogerwilco@blindza.xyz', 'Roger-123', 'dev.blindza.com', 587, true, true, '2025-08-27 01:34:31.211879');
INSERT INTO queueing.tbl_queued_emails VALUES (10, 'Hello World', '<p>Hello, ||title|| ||full_names||</p><p><br/></p><p><br/></p><p><a href="https://dev.blindza.com/bulk_mail/reroute/c9591432-7214-4344-a2ee-a41c146edae8" target="_blank">BlindZA</a></p>', 6, 6, '2025-08-20 01:31:00', 'rogerwilco@blindza.xyz', '', '999888777', true, true, '2025-08-27 02:11:02.204983', 'total of 20 - 20 ''good'' and 0 ''bad''', 'rogerwilco@blindza.xyz', 'Roger-123', 'dev.blindza.com', 587, true, true, '2025-08-27 02:10:22.141133');
INSERT INTO queueing.tbl_queued_emails VALUES (11, 'Hello World', '<p>Hello, ||title|| ||full_names||</p><p><br/></p><p><br/></p><p><a href="https://dev.blindza.com/bulk_mail/reroute/79cd7bca-8058-49a1-a011-a9598d1403b9" target="_blank">BlindZA</a></p>', 6, 6, '2025-08-20 01:31:00', 'rogerwilco@blindza.xyz', '', '999888777', true, true, '2025-08-27 12:22:23.130642', 'total of 20 - 20 ''good'' and 0 ''bad''', 'rogerwilco@blindza.xyz', 'Roger-123', 'dev.blindza.com', 587, true, true, '2025-08-27 12:21:43.086788');
INSERT INTO queueing.tbl_queued_emails VALUES (12, 'Dr. Healer is closed on Sundays', '<p>||title||&nbsp;||full_names||</p><p><br></p><p>Good day ||title|| ||full_names||<br><br>Please note that we are closed on Sundays.&nbsp;<br><br>Best regards,&nbsp;<br>Doctor Healer</p><p><br></p><p>||mobile||</p><p><br></p><p><br></p>', 6, 7, '2025-10-29 10:39:00', 'rogerwilco@blindza.xyz', 'sagwatishiburi1@gmail.com', 'Dr Sunday Operating Hours', false, true, NULL, '', 'rogerwilco@blindza.xyz', 'Roger-123', 'dev.blindza.com', 587, true, true, NULL);


--
-- Name: tbl_users_id_seq; Type: SEQUENCE SET; Schema: authentication; Owner: bulkmail_user
--

SELECT pg_catalog.setval('authentication.tbl_users_id_seq', 7, true);


--
-- Name: tbl_companies_id_seq; Type: SEQUENCE SET; Schema: companies; Owner: bulkmail_user
--

SELECT pg_catalog.setval('companies.tbl_companies_id_seq', 8, true);


--
-- Name: tbl_company_email_addresses_id_seq; Type: SEQUENCE SET; Schema: companies; Owner: bulkmail_user
--

SELECT pg_catalog.setval('companies.tbl_company_email_addresses_id_seq', 3, true);


--
-- Name: tbl_countries_id_seq; Type: SEQUENCE SET; Schema: companies; Owner: bulkmail_user
--

SELECT pg_catalog.setval('companies.tbl_countries_id_seq', 242, true);


--
-- Name: tbl_id_types_id_seq; Type: SEQUENCE SET; Schema: companies; Owner: bulkmail_user
--

SELECT pg_catalog.setval('companies.tbl_id_types_id_seq', 7, true);


--
-- Name: tbl_customer_group_members_id_seq; Type: SEQUENCE SET; Schema: customers; Owner: bulkmail_user
--

SELECT pg_catalog.setval('customers.tbl_customer_group_members_id_seq', 57, true);


--
-- Name: tbl_customer_groups_id_seq; Type: SEQUENCE SET; Schema: customers; Owner: bulkmail_user
--

SELECT pg_catalog.setval('customers.tbl_customer_groups_id_seq', 6, true);


--
-- Name: tbl_customers_companies_id_seq; Type: SEQUENCE SET; Schema: customers; Owner: bulkmail_user
--

SELECT pg_catalog.setval('customers.tbl_customers_companies_id_seq', 51, true);


--
-- Name: tbl_customers_id_seq; Type: SEQUENCE SET; Schema: customers; Owner: bulkmail_user
--

SELECT pg_catalog.setval('customers.tbl_customers_id_seq', 62, true);


--
-- Name: tbl_id_types_id_seq; Type: SEQUENCE SET; Schema: customers; Owner: bulkmail_user
--

SELECT pg_catalog.setval('customers.tbl_id_types_id_seq', 8, true);


--
-- Name: tbl_attachments_id_seq; Type: SEQUENCE SET; Schema: emails; Owner: bulkmail_user
--

SELECT pg_catalog.setval('emails.tbl_attachments_id_seq', 3, true);


--
-- Name: tbl_campaign_customers_id_seq; Type: SEQUENCE SET; Schema: emails; Owner: bulkmail_user
--

SELECT pg_catalog.setval('emails.tbl_campaign_customers_id_seq', 1, false);


--
-- Name: tbl_campaign_groups_id_seq; Type: SEQUENCE SET; Schema: emails; Owner: bulkmail_user
--

SELECT pg_catalog.setval('emails.tbl_campaign_groups_id_seq', 14, true);


--
-- Name: tbl_campaigns_id_seq; Type: SEQUENCE SET; Schema: emails; Owner: bulkmail_user
--

SELECT pg_catalog.setval('emails.tbl_campaigns_id_seq', 7, true);


--
-- Name: tbl_emails_id_seq; Type: SEQUENCE SET; Schema: emails; Owner: bulkmail_user
--

SELECT pg_catalog.setval('emails.tbl_emails_id_seq', 5, true);


--
-- Name: tbl_email_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: bulkmail_user
--

SELECT pg_catalog.setval('public.tbl_email_addresses_id_seq', 1, false);


--
-- Name: tbl_emails_id_seq; Type: SEQUENCE SET; Schema: queueing; Owner: bulkmail_user
--

SELECT pg_catalog.setval('queueing.tbl_emails_id_seq', 12, true);


--
-- Name: tbl_queued_attachments_id_seq; Type: SEQUENCE SET; Schema: queueing; Owner: bulkmail_user
--

SELECT pg_catalog.setval('queueing.tbl_queued_attachments_id_seq', 4, true);


--
-- Name: tbl_queued_click_through_records_id_seq; Type: SEQUENCE SET; Schema: queueing; Owner: bulkmail_user
--

SELECT pg_catalog.setval('queueing.tbl_queued_click_through_records_id_seq', 1, true);


--
-- Name: tbl_queued_click_throughs_id_seq; Type: SEQUENCE SET; Schema: queueing; Owner: bulkmail_user
--

SELECT pg_catalog.setval('queueing.tbl_queued_click_throughs_id_seq', 2, true);


--
-- Name: tbl_queued_customers_id_seq; Type: SEQUENCE SET; Schema: queueing; Owner: bulkmail_user
--

SELECT pg_catalog.setval('queueing.tbl_queued_customers_id_seq', 127, true);


--
-- Name: tbl_users tbl_users_pkey; Type: CONSTRAINT; Schema: authentication; Owner: bulkmail_user
--

ALTER TABLE ONLY authentication.tbl_users
    ADD CONSTRAINT tbl_users_pkey PRIMARY KEY (id);


--
-- Name: tbl_companies tbl_companies_pkey; Type: CONSTRAINT; Schema: companies; Owner: bulkmail_user
--

ALTER TABLE ONLY companies.tbl_companies
    ADD CONSTRAINT tbl_companies_pkey PRIMARY KEY (id);


--
-- Name: tbl_company_email_addresses tbl_company_email_addresses_pkey; Type: CONSTRAINT; Schema: companies; Owner: bulkmail_user
--

ALTER TABLE ONLY companies.tbl_company_email_addresses
    ADD CONSTRAINT tbl_company_email_addresses_pkey PRIMARY KEY (id);


--
-- Name: tbl_countries tbl_countries_pkey; Type: CONSTRAINT; Schema: companies; Owner: bulkmail_user
--

ALTER TABLE ONLY companies.tbl_countries
    ADD CONSTRAINT tbl_countries_pkey PRIMARY KEY (id);


--
-- Name: tbl_id_types tbl_id_types_pkey; Type: CONSTRAINT; Schema: companies; Owner: bulkmail_user
--

ALTER TABLE ONLY companies.tbl_id_types
    ADD CONSTRAINT tbl_id_types_pkey PRIMARY KEY (id);


--
-- Name: tbl_customer_group_members tbl_customer_group_members_pkey; Type: CONSTRAINT; Schema: customers; Owner: bulkmail_user
--

ALTER TABLE ONLY customers.tbl_customer_group_members
    ADD CONSTRAINT tbl_customer_group_members_pkey PRIMARY KEY (id);


--
-- Name: tbl_customer_groups tbl_customer_groups_pkey; Type: CONSTRAINT; Schema: customers; Owner: bulkmail_user
--

ALTER TABLE ONLY customers.tbl_customer_groups
    ADD CONSTRAINT tbl_customer_groups_pkey PRIMARY KEY (id);


--
-- Name: tbl_customers_companies tbl_customers_companies_pkey; Type: CONSTRAINT; Schema: customers; Owner: bulkmail_user
--

ALTER TABLE ONLY customers.tbl_customers_companies
    ADD CONSTRAINT tbl_customers_companies_pkey PRIMARY KEY (id);


--
-- Name: tbl_customers tbl_customers_pkey; Type: CONSTRAINT; Schema: customers; Owner: bulkmail_user
--

ALTER TABLE ONLY customers.tbl_customers
    ADD CONSTRAINT tbl_customers_pkey PRIMARY KEY (id);


--
-- Name: tbl_id_types tbl_id_types_pkey; Type: CONSTRAINT; Schema: customers; Owner: bulkmail_user
--

ALTER TABLE ONLY customers.tbl_id_types
    ADD CONSTRAINT tbl_id_types_pkey PRIMARY KEY (id);


--
-- Name: tbl_attachments tbl_attachments_pkey; Type: CONSTRAINT; Schema: emails; Owner: bulkmail_user
--

ALTER TABLE ONLY emails.tbl_attachments
    ADD CONSTRAINT tbl_attachments_pkey PRIMARY KEY (id);


--
-- Name: tbl_campaign_customers tbl_campaign_customers_pkey; Type: CONSTRAINT; Schema: emails; Owner: bulkmail_user
--

ALTER TABLE ONLY emails.tbl_campaign_customers
    ADD CONSTRAINT tbl_campaign_customers_pkey PRIMARY KEY (id);


--
-- Name: tbl_campaign_groups tbl_campaign_groups_pkey; Type: CONSTRAINT; Schema: emails; Owner: bulkmail_user
--

ALTER TABLE ONLY emails.tbl_campaign_groups
    ADD CONSTRAINT tbl_campaign_groups_pkey PRIMARY KEY (id);


--
-- Name: tbl_campaigns tbl_campaigns_pkey; Type: CONSTRAINT; Schema: emails; Owner: bulkmail_user
--

ALTER TABLE ONLY emails.tbl_campaigns
    ADD CONSTRAINT tbl_campaigns_pkey PRIMARY KEY (id);


--
-- Name: tbl_emails tbl_emails_pkey; Type: CONSTRAINT; Schema: emails; Owner: bulkmail_user
--

ALTER TABLE ONLY emails.tbl_emails
    ADD CONSTRAINT tbl_emails_pkey PRIMARY KEY (id);


--
-- Name: tbl_queued_emails tbl_emails_pkey; Type: CONSTRAINT; Schema: queueing; Owner: bulkmail_user
--

ALTER TABLE ONLY queueing.tbl_queued_emails
    ADD CONSTRAINT tbl_emails_pkey PRIMARY KEY (id);


--
-- Name: tbl_queued_attachments tbl_queued_attachments_pkey; Type: CONSTRAINT; Schema: queueing; Owner: bulkmail_user
--

ALTER TABLE ONLY queueing.tbl_queued_attachments
    ADD CONSTRAINT tbl_queued_attachments_pkey PRIMARY KEY (id);


--
-- Name: tbl_queued_click_through_records tbl_queued_click_through_records_pkey; Type: CONSTRAINT; Schema: queueing; Owner: bulkmail_user
--

ALTER TABLE ONLY queueing.tbl_queued_click_through_records
    ADD CONSTRAINT tbl_queued_click_through_records_pkey PRIMARY KEY (id);


--
-- Name: tbl_queued_click_throughs tbl_queued_click_throughs_pkey; Type: CONSTRAINT; Schema: queueing; Owner: bulkmail_user
--

ALTER TABLE ONLY queueing.tbl_queued_click_throughs
    ADD CONSTRAINT tbl_queued_click_throughs_pkey PRIMARY KEY (id);


--
-- Name: tbl_queued_customers tbl_queued_customers_pkey; Type: CONSTRAINT; Schema: queueing; Owner: bulkmail_user
--

ALTER TABLE ONLY queueing.tbl_queued_customers
    ADD CONSTRAINT tbl_queued_customers_pkey PRIMARY KEY (id);


--
-- Name: tbl_companies tbl_companies_i_country_fkey; Type: FK CONSTRAINT; Schema: companies; Owner: bulkmail_user
--

ALTER TABLE ONLY companies.tbl_companies
    ADD CONSTRAINT tbl_companies_i_country_fkey FOREIGN KEY (i_country) REFERENCES companies.tbl_countries(id);


--
-- Name: tbl_company_email_addresses tbl_company_email_addresses_i_company_id_fkey; Type: FK CONSTRAINT; Schema: companies; Owner: bulkmail_user
--

ALTER TABLE ONLY companies.tbl_company_email_addresses
    ADD CONSTRAINT tbl_company_email_addresses_i_company_id_fkey FOREIGN KEY (i_company_id) REFERENCES companies.tbl_companies(id) ON DELETE CASCADE;


--
-- Name: tbl_customer_group_members tbl_customer_group_members_i_customer_id_fkey; Type: FK CONSTRAINT; Schema: customers; Owner: bulkmail_user
--

ALTER TABLE ONLY customers.tbl_customer_group_members
    ADD CONSTRAINT tbl_customer_group_members_i_customer_id_fkey FOREIGN KEY (i_customer_id) REFERENCES customers.tbl_customers(id) ON DELETE CASCADE;


--
-- Name: tbl_customer_group_members tbl_customer_group_members_i_group_id_fkey; Type: FK CONSTRAINT; Schema: customers; Owner: bulkmail_user
--

ALTER TABLE ONLY customers.tbl_customer_group_members
    ADD CONSTRAINT tbl_customer_group_members_i_group_id_fkey FOREIGN KEY (i_group_id) REFERENCES customers.tbl_customer_groups(id) ON DELETE CASCADE;


--
-- Name: tbl_customer_groups tbl_customer_groups_i_company_id_fkey; Type: FK CONSTRAINT; Schema: customers; Owner: bulkmail_user
--

ALTER TABLE ONLY customers.tbl_customer_groups
    ADD CONSTRAINT tbl_customer_groups_i_company_id_fkey FOREIGN KEY (i_company_id) REFERENCES companies.tbl_companies(id) ON DELETE CASCADE;


--
-- Name: tbl_customers_companies tbl_customers_companies_i_company_id_fkey; Type: FK CONSTRAINT; Schema: customers; Owner: bulkmail_user
--

ALTER TABLE ONLY customers.tbl_customers_companies
    ADD CONSTRAINT tbl_customers_companies_i_company_id_fkey FOREIGN KEY (i_company_id) REFERENCES companies.tbl_companies(id) ON DELETE CASCADE;


--
-- Name: tbl_customers_companies tbl_customers_companies_i_customer_id_fkey; Type: FK CONSTRAINT; Schema: customers; Owner: bulkmail_user
--

ALTER TABLE ONLY customers.tbl_customers_companies
    ADD CONSTRAINT tbl_customers_companies_i_customer_id_fkey FOREIGN KEY (i_customer_id) REFERENCES customers.tbl_customers(id) ON DELETE CASCADE;


--
-- Name: tbl_attachments tbl_attachments_i_campaign_id_fkey; Type: FK CONSTRAINT; Schema: emails; Owner: bulkmail_user
--

ALTER TABLE ONLY emails.tbl_attachments
    ADD CONSTRAINT tbl_attachments_i_campaign_id_fkey FOREIGN KEY (i_campaign_id) REFERENCES emails.tbl_campaigns(id) ON DELETE CASCADE;


--
-- Name: tbl_campaign_groups tbl_campaign_groups_i_campaign_id_fkey; Type: FK CONSTRAINT; Schema: emails; Owner: bulkmail_user
--

ALTER TABLE ONLY emails.tbl_campaign_groups
    ADD CONSTRAINT tbl_campaign_groups_i_campaign_id_fkey FOREIGN KEY (i_campaign_id) REFERENCES emails.tbl_campaigns(id) ON DELETE CASCADE;


--
-- Name: tbl_campaign_groups tbl_campaign_groups_i_group_id_fkey; Type: FK CONSTRAINT; Schema: emails; Owner: bulkmail_user
--

ALTER TABLE ONLY emails.tbl_campaign_groups
    ADD CONSTRAINT tbl_campaign_groups_i_group_id_fkey FOREIGN KEY (i_group_id) REFERENCES customers.tbl_customer_groups(id) ON DELETE CASCADE;


--
-- Name: tbl_campaigns tbl_campaigns_i_company_email_address_id_fkey; Type: FK CONSTRAINT; Schema: emails; Owner: bulkmail_user
--

ALTER TABLE ONLY emails.tbl_campaigns
    ADD CONSTRAINT tbl_campaigns_i_company_email_address_id_fkey FOREIGN KEY (i_company_email_address_id) REFERENCES companies.tbl_company_email_addresses(id);


--
-- Name: tbl_campaigns tbl_campaigns_i_company_id_fkey; Type: FK CONSTRAINT; Schema: emails; Owner: bulkmail_user
--

ALTER TABLE ONLY emails.tbl_campaigns
    ADD CONSTRAINT tbl_campaigns_i_company_id_fkey FOREIGN KEY (i_company_id) REFERENCES companies.tbl_companies(id);


--
-- Name: tbl_campaigns tbl_campaigns_i_email_id_fkey; Type: FK CONSTRAINT; Schema: emails; Owner: bulkmail_user
--

ALTER TABLE ONLY emails.tbl_campaigns
    ADD CONSTRAINT tbl_campaigns_i_email_id_fkey FOREIGN KEY (i_email_id) REFERENCES emails.tbl_emails(id);


--
-- Name: tbl_emails tbl_emails_i_company_id_fkey; Type: FK CONSTRAINT; Schema: emails; Owner: bulkmail_user
--

ALTER TABLE ONLY emails.tbl_emails
    ADD CONSTRAINT tbl_emails_i_company_id_fkey FOREIGN KEY (i_company_id) REFERENCES companies.tbl_companies(id) ON DELETE CASCADE;


--
-- Name: tbl_queued_attachments tbl_queued_attachments_i_email_id_fkey; Type: FK CONSTRAINT; Schema: queueing; Owner: bulkmail_user
--

ALTER TABLE ONLY queueing.tbl_queued_attachments
    ADD CONSTRAINT tbl_queued_attachments_i_email_id_fkey FOREIGN KEY (i_queued_email_id) REFERENCES queueing.tbl_queued_emails(id) ON DELETE CASCADE;


--
-- Name: tbl_queued_click_through_records tbl_queued_click_through_records_i_queued_click_through_id_fkey; Type: FK CONSTRAINT; Schema: queueing; Owner: bulkmail_user
--

ALTER TABLE ONLY queueing.tbl_queued_click_through_records
    ADD CONSTRAINT tbl_queued_click_through_records_i_queued_click_through_id_fkey FOREIGN KEY (i_queued_click_through_id) REFERENCES queueing.tbl_queued_click_throughs(id) ON DELETE CASCADE;


--
-- Name: tbl_queued_click_through_records tbl_queued_click_through_records_i_queued_customer_id_fkey; Type: FK CONSTRAINT; Schema: queueing; Owner: bulkmail_user
--

ALTER TABLE ONLY queueing.tbl_queued_click_through_records
    ADD CONSTRAINT tbl_queued_click_through_records_i_queued_customer_id_fkey FOREIGN KEY (i_queued_customer_id) REFERENCES queueing.tbl_queued_customers(id) ON DELETE CASCADE;


--
-- Name: tbl_queued_click_throughs tbl_queued_click_throughs_i_queued_email_id_fkey; Type: FK CONSTRAINT; Schema: queueing; Owner: bulkmail_user
--

ALTER TABLE ONLY queueing.tbl_queued_click_throughs
    ADD CONSTRAINT tbl_queued_click_throughs_i_queued_email_id_fkey FOREIGN KEY (i_queued_email_id) REFERENCES queueing.tbl_queued_emails(id) ON DELETE CASCADE;


--
-- Name: tbl_queued_customers tbl_queued_customers_i_queued_email_id_fkey; Type: FK CONSTRAINT; Schema: queueing; Owner: bulkmail_user
--

ALTER TABLE ONLY queueing.tbl_queued_customers
    ADD CONSTRAINT tbl_queued_customers_i_queued_email_id_fkey FOREIGN KEY (i_queued_email_id) REFERENCES queueing.tbl_queued_emails(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

