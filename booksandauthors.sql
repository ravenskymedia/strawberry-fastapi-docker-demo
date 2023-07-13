--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-1.pgdg120+1)
-- Dumped by pg_dump version 15.3 (Debian 15.3-1.pgdg120+1)

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
-- Name: authors; Type: TABLE; Schema: public; Owner: mbroms
--

CREATE TABLE public.authors (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.authors OWNER TO mbroms;

--
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: mbroms
--

CREATE SEQUENCE public.authors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authors_id_seq OWNER TO mbroms;

--
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mbroms
--

ALTER SEQUENCE public.authors_id_seq OWNED BY public.authors.id;


--
-- Name: books; Type: TABLE; Schema: public; Owner: mbroms
--

CREATE TABLE public.books (
    id integer NOT NULL,
    name character varying NOT NULL,
    author_id integer
);


ALTER TABLE public.books OWNER TO mbroms;

--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: mbroms
--

CREATE SEQUENCE public.books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.books_id_seq OWNER TO mbroms;

--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mbroms
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- Name: authors id; Type: DEFAULT; Schema: public; Owner: mbroms
--

ALTER TABLE ONLY public.authors ALTER COLUMN id SET DEFAULT nextval('public.authors_id_seq'::regclass);


--
-- Name: books id; Type: DEFAULT; Schema: public; Owner: mbroms
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: mbroms
--

COPY public.authors (id, name) FROM stdin;
1	Eric Idle
2	Biggie Smalls
\.


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: mbroms
--

COPY public.books (id, name, author_id) FROM stdin;
1	How To Be Funny	1
2	Size Matters	2
3	The Full Monty	1
\.


--
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mbroms
--

SELECT pg_catalog.setval('public.authors_id_seq', 2, true);


--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mbroms
--

SELECT pg_catalog.setval('public.books_id_seq', 3, true);


--
-- Name: authors authors_name_key; Type: CONSTRAINT; Schema: public; Owner: mbroms
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_name_key UNIQUE (name);


--
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: mbroms
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: mbroms
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: ix_authors_id; Type: INDEX; Schema: public; Owner: mbroms
--

CREATE INDEX ix_authors_id ON public.authors USING btree (id);


--
-- Name: ix_books_id; Type: INDEX; Schema: public; Owner: mbroms
--

CREATE INDEX ix_books_id ON public.books USING btree (id);


--
-- Name: books books_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mbroms
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.authors(id);


--
-- PostgreSQL database dump complete
--

