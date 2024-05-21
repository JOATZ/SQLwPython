--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    group_name text NOT NULL
);


ALTER TABLE public.groups OWNER TO postgres;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO postgres;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- Name: qr_codes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qr_codes (
    id integer NOT NULL,
    group_id integer,
    landing_url text NOT NULL,
    redirect_url text NOT NULL,
    qr_img bytea NOT NULL
);


ALTER TABLE public.qr_codes OWNER TO postgres;

--
-- Name: qr_codes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.qr_codes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.qr_codes_id_seq OWNER TO postgres;

--
-- Name: qr_codes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.qr_codes_id_seq OWNED BY public.qr_codes.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    name text NOT NULL,
    paid_user boolean DEFAULT false
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- Name: qr_codes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qr_codes ALTER COLUMN id SET DEFAULT nextval('public.qr_codes_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groups (id, group_name) FROM stdin;
1	Group 1
\.


--
-- Data for Name: qr_codes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.qr_codes (id, group_id, landing_url, redirect_url, qr_img) FROM stdin;
3	1	http://example.com	http://redirect.com	\\x
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password, name, paid_user) FROM stdin;
1	codeName	password	First_Last	t
\.


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groups_id_seq', 1, true);


--
-- Name: qr_codes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.qr_codes_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: qr_codes qr_codes_landing_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qr_codes
    ADD CONSTRAINT qr_codes_landing_url_key UNIQUE (landing_url);


--
-- Name: qr_codes qr_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qr_codes
    ADD CONSTRAINT qr_codes_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: groups fk_owner; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT fk_owner FOREIGN KEY (id) REFERENCES public.users(id);


--
-- Name: qr_codes fk_usergroup; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qr_codes
    ADD CONSTRAINT fk_usergroup FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- PostgreSQL database dump complete
--

