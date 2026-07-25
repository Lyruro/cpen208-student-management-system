--
-- PostgreSQL database dump
--

\restrict UyFTvZbjbryz9jPGlBSDFzgigrJNrgQeLkFBikEsttNoawzlRHEYjwJjwfncESH

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-07-25 02:18:08

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 24687)
-- Name: university; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA university;


ALTER SCHEMA university OWNER TO postgres;

--
-- TOC entry 235 (class 1255 OID 24801)
-- Name: calculate_outstanding_fees(); Type: FUNCTION; Schema: university; Owner: postgres
--

CREATE FUNCTION university.calculate_outstanding_fees() RETURNS json
    LANGUAGE plpgsql
    AS $$
DECLARE
    result JSON;
BEGIN

SELECT json_agg(
    json_build_object(
        'student_id', s.student_id,
        'student_name', CONCAT(s.first_name, ' ', s.last_name),
        'total_fees', s.total_fees,
        'amount_paid', COALESCE(fp.total_paid,0),
        'outstanding_fees',
            s.total_fees - COALESCE(fp.total_paid,0)
    )
)
INTO result

FROM university.student s

LEFT JOIN
(
    SELECT
        student_id,
        SUM(amount_paid) AS total_paid
    FROM university.fee_payment
    GROUP BY student_id
) fp

ON s.student_id = fp.student_id;

RETURN result;

END;
$$;


ALTER FUNCTION university.calculate_outstanding_fees() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 24700)
-- Name: course; Type: TABLE; Schema: university; Owner: postgres
--

CREATE TABLE university.course (
    course_id integer NOT NULL,
    course_code character varying(20) NOT NULL,
    course_name character varying(100) NOT NULL,
    credit_hours integer NOT NULL,
    semester integer NOT NULL
);


ALTER TABLE university.course OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24699)
-- Name: course_course_id_seq; Type: SEQUENCE; Schema: university; Owner: postgres
--

CREATE SEQUENCE university.course_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE university.course_course_id_seq OWNER TO postgres;

--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 221
-- Name: course_course_id_seq; Type: SEQUENCE OWNED BY; Schema: university; Owner: postgres
--

ALTER SEQUENCE university.course_course_id_seq OWNED BY university.course.course_id;


--
-- TOC entry 228 (class 1259 OID 24734)
-- Name: enrollment; Type: TABLE; Schema: university; Owner: postgres
--

CREATE TABLE university.enrollment (
    enrollment_id integer NOT NULL,
    student_id character varying(15),
    course_id integer,
    semester integer,
    academic_year character varying(20)
);


ALTER TABLE university.enrollment OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24733)
-- Name: enrollment_enrollment_id_seq; Type: SEQUENCE; Schema: university; Owner: postgres
--

CREATE SEQUENCE university.enrollment_enrollment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE university.enrollment_enrollment_id_seq OWNER TO postgres;

--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 227
-- Name: enrollment_enrollment_id_seq; Type: SEQUENCE OWNED BY; Schema: university; Owner: postgres
--

ALTER SEQUENCE university.enrollment_enrollment_id_seq OWNED BY university.enrollment.enrollment_id;


--
-- TOC entry 230 (class 1259 OID 24752)
-- Name: fee_payment; Type: TABLE; Schema: university; Owner: postgres
--

CREATE TABLE university.fee_payment (
    payment_id integer NOT NULL,
    student_id character varying(15),
    amount_paid numeric(10,2) NOT NULL,
    payment_date date,
    semester integer,
    academic_year character varying(20)
);


ALTER TABLE university.fee_payment OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24751)
-- Name: fee_payment_payment_id_seq; Type: SEQUENCE; Schema: university; Owner: postgres
--

CREATE SEQUENCE university.fee_payment_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE university.fee_payment_payment_id_seq OWNER TO postgres;

--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 229
-- Name: fee_payment_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: university; Owner: postgres
--

ALTER SEQUENCE university.fee_payment_payment_id_seq OWNED BY university.fee_payment.payment_id;


--
-- TOC entry 224 (class 1259 OID 24714)
-- Name: lecturer; Type: TABLE; Schema: university; Owner: postgres
--

CREATE TABLE university.lecturer (
    lecturer_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(100),
    office character varying(50)
);


ALTER TABLE university.lecturer OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 24766)
-- Name: lecturer_course; Type: TABLE; Schema: university; Owner: postgres
--

CREATE TABLE university.lecturer_course (
    assignment_id integer NOT NULL,
    lecturer_id integer,
    course_id integer
);


ALTER TABLE university.lecturer_course OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 24765)
-- Name: lecturer_course_assignment_id_seq; Type: SEQUENCE; Schema: university; Owner: postgres
--

CREATE SEQUENCE university.lecturer_course_assignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE university.lecturer_course_assignment_id_seq OWNER TO postgres;

--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 231
-- Name: lecturer_course_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: university; Owner: postgres
--

ALTER SEQUENCE university.lecturer_course_assignment_id_seq OWNED BY university.lecturer_course.assignment_id;


--
-- TOC entry 223 (class 1259 OID 24713)
-- Name: lecturer_lecturer_id_seq; Type: SEQUENCE; Schema: university; Owner: postgres
--

CREATE SEQUENCE university.lecturer_lecturer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE university.lecturer_lecturer_id_seq OWNER TO postgres;

--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 223
-- Name: lecturer_lecturer_id_seq; Type: SEQUENCE OWNED BY; Schema: university; Owner: postgres
--

ALTER SEQUENCE university.lecturer_lecturer_id_seq OWNED BY university.lecturer.lecturer_id;


--
-- TOC entry 234 (class 1259 OID 24784)
-- Name: lecturer_ta; Type: TABLE; Schema: university; Owner: postgres
--

CREATE TABLE university.lecturer_ta (
    assignment_id integer NOT NULL,
    lecturer_id integer,
    ta_id integer
);


ALTER TABLE university.lecturer_ta OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 24783)
-- Name: lecturer_ta_assignment_id_seq; Type: SEQUENCE; Schema: university; Owner: postgres
--

CREATE SEQUENCE university.lecturer_ta_assignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE university.lecturer_ta_assignment_id_seq OWNER TO postgres;

--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 233
-- Name: lecturer_ta_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: university; Owner: postgres
--

ALTER SEQUENCE university.lecturer_ta_assignment_id_seq OWNED BY university.lecturer_ta.assignment_id;


--
-- TOC entry 220 (class 1259 OID 24688)
-- Name: student; Type: TABLE; Schema: university; Owner: postgres
--

CREATE TABLE university.student (
    student_id character varying(15) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    gender character varying(10),
    email character varying(100),
    phone character varying(20),
    level integer,
    programme character varying(100),
    total_fees numeric(10,2) NOT NULL
);


ALTER TABLE university.student OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 24724)
-- Name: teaching_assistant; Type: TABLE; Schema: university; Owner: postgres
--

CREATE TABLE university.teaching_assistant (
    ta_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(100)
);


ALTER TABLE university.teaching_assistant OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24723)
-- Name: teaching_assistant_ta_id_seq; Type: SEQUENCE; Schema: university; Owner: postgres
--

CREATE SEQUENCE university.teaching_assistant_ta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE university.teaching_assistant_ta_id_seq OWNER TO postgres;

--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 225
-- Name: teaching_assistant_ta_id_seq; Type: SEQUENCE OWNED BY; Schema: university; Owner: postgres
--

ALTER SEQUENCE university.teaching_assistant_ta_id_seq OWNED BY university.teaching_assistant.ta_id;


--
-- TOC entry 4892 (class 2604 OID 24703)
-- Name: course course_id; Type: DEFAULT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.course ALTER COLUMN course_id SET DEFAULT nextval('university.course_course_id_seq'::regclass);


--
-- TOC entry 4895 (class 2604 OID 24737)
-- Name: enrollment enrollment_id; Type: DEFAULT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.enrollment ALTER COLUMN enrollment_id SET DEFAULT nextval('university.enrollment_enrollment_id_seq'::regclass);


--
-- TOC entry 4896 (class 2604 OID 24755)
-- Name: fee_payment payment_id; Type: DEFAULT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.fee_payment ALTER COLUMN payment_id SET DEFAULT nextval('university.fee_payment_payment_id_seq'::regclass);


--
-- TOC entry 4893 (class 2604 OID 24717)
-- Name: lecturer lecturer_id; Type: DEFAULT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.lecturer ALTER COLUMN lecturer_id SET DEFAULT nextval('university.lecturer_lecturer_id_seq'::regclass);


--
-- TOC entry 4897 (class 2604 OID 24769)
-- Name: lecturer_course assignment_id; Type: DEFAULT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.lecturer_course ALTER COLUMN assignment_id SET DEFAULT nextval('university.lecturer_course_assignment_id_seq'::regclass);


--
-- TOC entry 4898 (class 2604 OID 24787)
-- Name: lecturer_ta assignment_id; Type: DEFAULT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.lecturer_ta ALTER COLUMN assignment_id SET DEFAULT nextval('university.lecturer_ta_assignment_id_seq'::regclass);


--
-- TOC entry 4894 (class 2604 OID 24727)
-- Name: teaching_assistant ta_id; Type: DEFAULT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.teaching_assistant ALTER COLUMN ta_id SET DEFAULT nextval('university.teaching_assistant_ta_id_seq'::regclass);


--
-- TOC entry 5079 (class 0 OID 24700)
-- Dependencies: 222
-- Data for Name: course; Type: TABLE DATA; Schema: university; Owner: postgres
--

COPY university.course (course_id, course_code, course_name, credit_hours, semester) FROM stdin;
1	CPEN204	Data Structures and Algorithms	3	1
2	CPEN206	Digital Systems II	3	1
3	CPEN208	Software Engineering	3	1
4	CPEN210	Database Systems	3	1
5	MATH202	Engineering Mathematics II	3	1
\.


--
-- TOC entry 5085 (class 0 OID 24734)
-- Dependencies: 228
-- Data for Name: enrollment; Type: TABLE DATA; Schema: university; Owner: postgres
--

COPY university.enrollment (enrollment_id, student_id, course_id, semester, academic_year) FROM stdin;
1	22384451	1	1	2025/2026
2	22357814	1	1	2025/2026
3	22375367	1	1	2025/2026
4	22397756	1	1	2025/2026
5	22369321	1	1	2025/2026
6	22301848	1	1	2025/2026
7	22339520	1	1	2025/2026
8	22333597	1	1	2025/2026
9	22268986	1	1	2025/2026
10	22381577	1	1	2025/2026
11	22315830	1	1	2025/2026
12	22388189	1	1	2025/2026
13	22393520	1	1	2025/2026
14	22312110	1	1	2025/2026
15	22300896	1	1	2025/2026
16	22397491	1	1	2025/2026
17	22387715	1	1	2025/2026
18	22382302	1	1	2025/2026
19	22379061	1	1	2025/2026
20	22368809	1	1	2025/2026
21	22370498	1	1	2025/2026
22	22382425	1	1	2025/2026
23	22396551	1	1	2025/2026
24	22398562	1	1	2025/2026
25	22398596	1	1	2025/2026
26	22385323	1	1	2025/2026
27	22303421	1	1	2025/2026
28	22407033	1	1	2025/2026
29	22299189	1	1	2025/2026
30	22407837	1	1	2025/2026
31	22412615	1	1	2025/2026
32	22411009	1	1	2025/2026
33	22382547	1	1	2025/2026
34	22373317	1	1	2025/2026
35	22339058	1	1	2025/2026
36	22302628	1	1	2025/2026
37	22396566	1	1	2025/2026
38	22325819	1	1	2025/2026
39	22344703	1	1	2025/2026
40	22306910	1	1	2025/2026
41	22385472	1	1	2025/2026
42	22399214	1	1	2025/2026
43	22263126	1	1	2025/2026
44	22373463	1	1	2025/2026
45	22381702	1	1	2025/2026
46	22387846	1	1	2025/2026
47	22263922	1	1	2025/2026
48	22401641	1	1	2025/2026
49	22403781	1	1	2025/2026
50	22304260	1	1	2025/2026
51	22304013	1	1	2025/2026
52	22302188	1	1	2025/2026
53	22299949	1	1	2025/2026
54	22415339	1	1	2025/2026
55	22328334	1	1	2025/2026
56	22412982	1	1	2025/2026
57	22321110	1	1	2025/2026
58	22306021	1	1	2025/2026
59	22385391	1	1	2025/2026
60	22394866	1	1	2025/2026
61	22382601	1	1	2025/2026
62	22271867	1	1	2025/2026
63	224018189	1	1	2025/2026
64	22407018	1	1	2025/2026
65	22376708	1	1	2025/2026
66	22377537	1	1	2025/2026
67	22400543	1	1	2025/2026
68	22402666	1	1	2025/2026
69	22416112	1	1	2025/2026
70	22395074	1	1	2025/2026
71	22384451	2	1	2025/2026
72	22357814	2	1	2025/2026
73	22375367	2	1	2025/2026
74	22397756	2	1	2025/2026
75	22369321	2	1	2025/2026
76	22301848	2	1	2025/2026
77	22339520	2	1	2025/2026
78	22333597	2	1	2025/2026
79	22268986	2	1	2025/2026
80	22381577	2	1	2025/2026
81	22315830	2	1	2025/2026
82	22388189	2	1	2025/2026
83	22393520	2	1	2025/2026
84	22312110	2	1	2025/2026
85	22300896	2	1	2025/2026
86	22397491	2	1	2025/2026
87	22387715	2	1	2025/2026
88	22382302	2	1	2025/2026
89	22379061	2	1	2025/2026
90	22368809	2	1	2025/2026
91	22370498	2	1	2025/2026
92	22382425	2	1	2025/2026
93	22396551	2	1	2025/2026
94	22398562	2	1	2025/2026
95	22398596	2	1	2025/2026
96	22385323	2	1	2025/2026
97	22303421	2	1	2025/2026
98	22407033	2	1	2025/2026
99	22299189	2	1	2025/2026
100	22407837	2	1	2025/2026
101	22412615	2	1	2025/2026
102	22411009	2	1	2025/2026
103	22382547	2	1	2025/2026
104	22373317	2	1	2025/2026
105	22339058	2	1	2025/2026
106	22302628	2	1	2025/2026
107	22396566	2	1	2025/2026
108	22325819	2	1	2025/2026
109	22344703	2	1	2025/2026
110	22306910	2	1	2025/2026
111	22385472	2	1	2025/2026
112	22399214	2	1	2025/2026
113	22263126	2	1	2025/2026
114	22373463	2	1	2025/2026
115	22381702	2	1	2025/2026
116	22387846	2	1	2025/2026
117	22263922	2	1	2025/2026
118	22401641	2	1	2025/2026
119	22403781	2	1	2025/2026
120	22304260	2	1	2025/2026
121	22304013	2	1	2025/2026
122	22302188	2	1	2025/2026
123	22299949	2	1	2025/2026
124	22415339	2	1	2025/2026
125	22328334	2	1	2025/2026
126	22412982	2	1	2025/2026
127	22321110	2	1	2025/2026
128	22306021	2	1	2025/2026
129	22385391	2	1	2025/2026
130	22394866	2	1	2025/2026
131	22382601	2	1	2025/2026
132	22271867	2	1	2025/2026
133	224018189	2	1	2025/2026
134	22407018	2	1	2025/2026
135	22376708	2	1	2025/2026
136	22377537	2	1	2025/2026
137	22400543	2	1	2025/2026
138	22402666	2	1	2025/2026
139	22416112	2	1	2025/2026
140	22395074	2	1	2025/2026
141	22384451	3	1	2025/2026
142	22357814	3	1	2025/2026
143	22375367	3	1	2025/2026
144	22397756	3	1	2025/2026
145	22369321	3	1	2025/2026
146	22301848	3	1	2025/2026
147	22339520	3	1	2025/2026
148	22333597	3	1	2025/2026
149	22268986	3	1	2025/2026
150	22381577	3	1	2025/2026
151	22315830	3	1	2025/2026
152	22388189	3	1	2025/2026
153	22393520	3	1	2025/2026
154	22312110	3	1	2025/2026
155	22300896	3	1	2025/2026
156	22397491	3	1	2025/2026
157	22387715	3	1	2025/2026
158	22382302	3	1	2025/2026
159	22379061	3	1	2025/2026
160	22368809	3	1	2025/2026
161	22370498	3	1	2025/2026
162	22382425	3	1	2025/2026
163	22396551	3	1	2025/2026
164	22398562	3	1	2025/2026
165	22398596	3	1	2025/2026
166	22385323	3	1	2025/2026
167	22303421	3	1	2025/2026
168	22407033	3	1	2025/2026
169	22299189	3	1	2025/2026
170	22407837	3	1	2025/2026
171	22412615	3	1	2025/2026
172	22411009	3	1	2025/2026
173	22382547	3	1	2025/2026
174	22373317	3	1	2025/2026
175	22339058	3	1	2025/2026
176	22302628	3	1	2025/2026
177	22396566	3	1	2025/2026
178	22325819	3	1	2025/2026
179	22344703	3	1	2025/2026
180	22306910	3	1	2025/2026
181	22385472	3	1	2025/2026
182	22399214	3	1	2025/2026
183	22263126	3	1	2025/2026
184	22373463	3	1	2025/2026
185	22381702	3	1	2025/2026
186	22387846	3	1	2025/2026
187	22263922	3	1	2025/2026
188	22401641	3	1	2025/2026
189	22403781	3	1	2025/2026
190	22304260	3	1	2025/2026
191	22304013	3	1	2025/2026
192	22302188	3	1	2025/2026
193	22299949	3	1	2025/2026
194	22415339	3	1	2025/2026
195	22328334	3	1	2025/2026
196	22412982	3	1	2025/2026
197	22321110	3	1	2025/2026
198	22306021	3	1	2025/2026
199	22385391	3	1	2025/2026
200	22394866	3	1	2025/2026
201	22382601	3	1	2025/2026
202	22271867	3	1	2025/2026
203	224018189	3	1	2025/2026
204	22407018	3	1	2025/2026
205	22376708	3	1	2025/2026
206	22377537	3	1	2025/2026
207	22400543	3	1	2025/2026
208	22402666	3	1	2025/2026
209	22416112	3	1	2025/2026
210	22395074	3	1	2025/2026
211	22384451	4	1	2025/2026
212	22357814	4	1	2025/2026
213	22375367	4	1	2025/2026
214	22397756	4	1	2025/2026
215	22369321	4	1	2025/2026
216	22301848	4	1	2025/2026
217	22339520	4	1	2025/2026
218	22333597	4	1	2025/2026
219	22268986	4	1	2025/2026
220	22381577	4	1	2025/2026
221	22315830	4	1	2025/2026
222	22388189	4	1	2025/2026
223	22393520	4	1	2025/2026
224	22312110	4	1	2025/2026
225	22300896	4	1	2025/2026
226	22397491	4	1	2025/2026
227	22387715	4	1	2025/2026
228	22382302	4	1	2025/2026
229	22379061	4	1	2025/2026
230	22368809	4	1	2025/2026
231	22370498	4	1	2025/2026
232	22382425	4	1	2025/2026
233	22396551	4	1	2025/2026
234	22398562	4	1	2025/2026
235	22398596	4	1	2025/2026
236	22385323	4	1	2025/2026
237	22303421	4	1	2025/2026
238	22407033	4	1	2025/2026
239	22299189	4	1	2025/2026
240	22407837	4	1	2025/2026
241	22412615	4	1	2025/2026
242	22411009	4	1	2025/2026
243	22382547	4	1	2025/2026
244	22373317	4	1	2025/2026
245	22339058	4	1	2025/2026
246	22302628	4	1	2025/2026
247	22396566	4	1	2025/2026
248	22325819	4	1	2025/2026
249	22344703	4	1	2025/2026
250	22306910	4	1	2025/2026
251	22385472	4	1	2025/2026
252	22399214	4	1	2025/2026
253	22263126	4	1	2025/2026
254	22373463	4	1	2025/2026
255	22381702	4	1	2025/2026
256	22387846	4	1	2025/2026
257	22263922	4	1	2025/2026
258	22401641	4	1	2025/2026
259	22403781	4	1	2025/2026
260	22304260	4	1	2025/2026
261	22304013	4	1	2025/2026
262	22302188	4	1	2025/2026
263	22299949	4	1	2025/2026
264	22415339	4	1	2025/2026
265	22328334	4	1	2025/2026
266	22412982	4	1	2025/2026
267	22321110	4	1	2025/2026
268	22306021	4	1	2025/2026
269	22385391	4	1	2025/2026
270	22394866	4	1	2025/2026
271	22382601	4	1	2025/2026
272	22271867	4	1	2025/2026
273	224018189	4	1	2025/2026
274	22407018	4	1	2025/2026
275	22376708	4	1	2025/2026
276	22377537	4	1	2025/2026
277	22400543	4	1	2025/2026
278	22402666	4	1	2025/2026
279	22416112	4	1	2025/2026
280	22395074	4	1	2025/2026
281	22384451	5	1	2025/2026
282	22357814	5	1	2025/2026
283	22375367	5	1	2025/2026
284	22397756	5	1	2025/2026
285	22369321	5	1	2025/2026
286	22301848	5	1	2025/2026
287	22339520	5	1	2025/2026
288	22333597	5	1	2025/2026
289	22268986	5	1	2025/2026
290	22381577	5	1	2025/2026
291	22315830	5	1	2025/2026
292	22388189	5	1	2025/2026
293	22393520	5	1	2025/2026
294	22312110	5	1	2025/2026
295	22300896	5	1	2025/2026
296	22397491	5	1	2025/2026
297	22387715	5	1	2025/2026
298	22382302	5	1	2025/2026
299	22379061	5	1	2025/2026
300	22368809	5	1	2025/2026
301	22370498	5	1	2025/2026
302	22382425	5	1	2025/2026
303	22396551	5	1	2025/2026
304	22398562	5	1	2025/2026
305	22398596	5	1	2025/2026
306	22385323	5	1	2025/2026
307	22303421	5	1	2025/2026
308	22407033	5	1	2025/2026
309	22299189	5	1	2025/2026
310	22407837	5	1	2025/2026
311	22412615	5	1	2025/2026
312	22411009	5	1	2025/2026
313	22382547	5	1	2025/2026
314	22373317	5	1	2025/2026
315	22339058	5	1	2025/2026
316	22302628	5	1	2025/2026
317	22396566	5	1	2025/2026
318	22325819	5	1	2025/2026
319	22344703	5	1	2025/2026
320	22306910	5	1	2025/2026
321	22385472	5	1	2025/2026
322	22399214	5	1	2025/2026
323	22263126	5	1	2025/2026
324	22373463	5	1	2025/2026
325	22381702	5	1	2025/2026
326	22387846	5	1	2025/2026
327	22263922	5	1	2025/2026
328	22401641	5	1	2025/2026
329	22403781	5	1	2025/2026
330	22304260	5	1	2025/2026
331	22304013	5	1	2025/2026
332	22302188	5	1	2025/2026
333	22299949	5	1	2025/2026
334	22415339	5	1	2025/2026
335	22328334	5	1	2025/2026
336	22412982	5	1	2025/2026
337	22321110	5	1	2025/2026
338	22306021	5	1	2025/2026
339	22385391	5	1	2025/2026
340	22394866	5	1	2025/2026
341	22382601	5	1	2025/2026
342	22271867	5	1	2025/2026
343	224018189	5	1	2025/2026
344	22407018	5	1	2025/2026
345	22376708	5	1	2025/2026
346	22377537	5	1	2025/2026
347	22400543	5	1	2025/2026
348	22402666	5	1	2025/2026
349	22416112	5	1	2025/2026
350	22395074	5	1	2025/2026
\.


--
-- TOC entry 5087 (class 0 OID 24752)
-- Dependencies: 230
-- Data for Name: fee_payment; Type: TABLE DATA; Schema: university; Owner: postgres
--

COPY university.fee_payment (payment_id, student_id, amount_paid, payment_date, semester, academic_year) FROM stdin;
1	22384451	5000.00	2026-07-23	1	2025/2026
2	22357814	3500.00	2026-07-23	1	2025/2026
3	22375367	3500.00	2026-07-23	1	2025/2026
4	22397756	1000.00	2026-07-23	1	2025/2026
5	22369321	3500.00	2026-07-23	1	2025/2026
6	22301848	5000.00	2026-07-23	1	2025/2026
7	22339520	5000.00	2026-07-23	1	2025/2026
8	22333597	3500.00	2026-07-23	1	2025/2026
9	22268986	3500.00	2026-07-23	1	2025/2026
10	22381577	2000.00	2026-07-23	1	2025/2026
11	22315830	3500.00	2026-07-23	1	2025/2026
12	22388189	5000.00	2026-07-23	1	2025/2026
13	22393520	2000.00	2026-07-23	1	2025/2026
14	22312110	5000.00	2026-07-23	1	2025/2026
15	22300896	2000.00	2026-07-23	1	2025/2026
16	22397491	3500.00	2026-07-23	1	2025/2026
17	22387715	3500.00	2026-07-23	1	2025/2026
18	22382302	5000.00	2026-07-23	1	2025/2026
19	22379061	1000.00	2026-07-23	1	2025/2026
20	22368809	3500.00	2026-07-23	1	2025/2026
21	22370498	3500.00	2026-07-23	1	2025/2026
22	22382425	3500.00	2026-07-23	1	2025/2026
23	22396551	3500.00	2026-07-23	1	2025/2026
24	22398562	5000.00	2026-07-23	1	2025/2026
25	22398596	2000.00	2026-07-23	1	2025/2026
26	22385323	2000.00	2026-07-23	1	2025/2026
27	22303421	2000.00	2026-07-23	1	2025/2026
28	22407033	3500.00	2026-07-23	1	2025/2026
29	22299189	3500.00	2026-07-23	1	2025/2026
30	22407837	3500.00	2026-07-23	1	2025/2026
31	22412615	2000.00	2026-07-23	1	2025/2026
32	22411009	3500.00	2026-07-23	1	2025/2026
33	22382547	2000.00	2026-07-23	1	2025/2026
34	22373317	2000.00	2026-07-23	1	2025/2026
35	22339058	2000.00	2026-07-23	1	2025/2026
36	22302628	2000.00	2026-07-23	1	2025/2026
37	22396566	5000.00	2026-07-23	1	2025/2026
38	22325819	2000.00	2026-07-23	1	2025/2026
39	22344703	3500.00	2026-07-23	1	2025/2026
40	22306910	3500.00	2026-07-23	1	2025/2026
41	22385472	3500.00	2026-07-23	1	2025/2026
42	22399214	1000.00	2026-07-23	1	2025/2026
43	22263126	2000.00	2026-07-23	1	2025/2026
44	22373463	3500.00	2026-07-23	1	2025/2026
45	22381702	3500.00	2026-07-23	1	2025/2026
46	22387846	3500.00	2026-07-23	1	2025/2026
47	22263922	3500.00	2026-07-23	1	2025/2026
48	22401641	1000.00	2026-07-23	1	2025/2026
49	22403781	2000.00	2026-07-23	1	2025/2026
50	22304260	3500.00	2026-07-23	1	2025/2026
51	22304013	3500.00	2026-07-23	1	2025/2026
52	22302188	3500.00	2026-07-23	1	2025/2026
53	22299949	1000.00	2026-07-23	1	2025/2026
54	22415339	5000.00	2026-07-23	1	2025/2026
55	22328334	3500.00	2026-07-23	1	2025/2026
56	22412982	3500.00	2026-07-23	1	2025/2026
57	22321110	1000.00	2026-07-23	1	2025/2026
58	22306021	2000.00	2026-07-23	1	2025/2026
59	22385391	2000.00	2026-07-23	1	2025/2026
60	22394866	3500.00	2026-07-23	1	2025/2026
61	22382601	5000.00	2026-07-23	1	2025/2026
62	22271867	3500.00	2026-07-23	1	2025/2026
63	224018189	3500.00	2026-07-23	1	2025/2026
64	22407018	3500.00	2026-07-23	1	2025/2026
65	22376708	3500.00	2026-07-23	1	2025/2026
66	22377537	3500.00	2026-07-23	1	2025/2026
67	22400543	5000.00	2026-07-23	1	2025/2026
68	22402666	3500.00	2026-07-23	1	2025/2026
69	22416112	3500.00	2026-07-23	1	2025/2026
70	22395074	3500.00	2026-07-23	1	2025/2026
\.


--
-- TOC entry 5081 (class 0 OID 24714)
-- Dependencies: 224
-- Data for Name: lecturer; Type: TABLE DATA; Schema: university; Owner: postgres
--

COPY university.lecturer (lecturer_id, first_name, last_name, email, office) FROM stdin;
1	Kwame	Mensah	kwame.mensah@ug.edu.gh	ENG201
2	Ama	Boateng	ama.boateng@ug.edu.gh	ENG205
3	Kojo	Asare	kojo.asare@ug.edu.gh	ENG210
4	Linda	Owusu	linda.owusu@ug.edu.gh	ENG212
5	Samuel	Addo	samuel.addo@ug.edu.gh	ENG220
\.


--
-- TOC entry 5089 (class 0 OID 24766)
-- Dependencies: 232
-- Data for Name: lecturer_course; Type: TABLE DATA; Schema: university; Owner: postgres
--

COPY university.lecturer_course (assignment_id, lecturer_id, course_id) FROM stdin;
1	1	1
2	2	2
3	3	3
4	4	4
5	5	5
\.


--
-- TOC entry 5091 (class 0 OID 24784)
-- Dependencies: 234
-- Data for Name: lecturer_ta; Type: TABLE DATA; Schema: university; Owner: postgres
--

COPY university.lecturer_ta (assignment_id, lecturer_id, ta_id) FROM stdin;
1	1	1
2	2	2
3	3	3
4	4	4
5	5	5
\.


--
-- TOC entry 5077 (class 0 OID 24688)
-- Dependencies: 220
-- Data for Name: student; Type: TABLE DATA; Schema: university; Owner: postgres
--

COPY university.student (student_id, first_name, last_name, gender, email, phone, level, programme, total_fees) FROM stdin;
22384451	Abu Neaquittae	Golda	N/A	abu.neaquittae.golda@ug.edu.gh		200	Computer Engineering	5000.00
22357814	Adzasa Stephen	Yaw	N/A	adzasa.stephen.yaw@ug.edu.gh		200	Computer Engineering	5000.00
22375367	Afia Beaa	Osei-Safo	N/A	afia.beaa.osei-safo@ug.edu.gh		200	Computer Engineering	5000.00
22397756	Agbemavi	Ryan	N/A	agbemavi.ryan@ug.edu.gh		200	Computer Engineering	5000.00
22369321	Agormeda Nathaniel	Tetteh	N/A	agormeda.nathaniel.tetteh@ug.edu.gh		200	Computer Engineering	5000.00
22301848	Ahmad Mohammed Sahih	Kayelgu	N/A	ahmad.mohammed.sahih.kayelgu@ug.edu.gh		200	Computer Engineering	5000.00
22339520	Amprofi Yaa	Obeng	N/A	amprofi.yaa.obeng@ug.edu.gh		200	Computer Engineering	5000.00
22333597	Asante Esme	Lilian	N/A	asante.esme.lilian@ug.edu.gh		200	Computer Engineering	5000.00
22268986	Asante Gabriel	Kwaku	N/A	asante.gabriel.kwaku@ug.edu.gh		200	Computer Engineering	5000.00
22381577	Botchway	Daniel	N/A	botchway.daniel@ug.edu.gh		200	Computer Engineering	5000.00
22315830	Brian	Assibey-Yeboah	N/A	brian.assibey-yeboah@ug.edu.gh		200	Computer Engineering	5000.00
22388189	Caleb	Mensah	N/A	caleb.mensah@ug.edu.gh		200	Computer Engineering	5000.00
22393520	Cyril Desmond	Ofori	N/A	cyril.desmond.ofori@ug.edu.gh		200	Computer Engineering	5000.00
22312110	David Kwame	Odoi-Anim	N/A	david.kwame.odoi-anim@ug.edu.gh		200	Computer Engineering	5000.00
22300896	Doe Collins	Kweku	N/A	doe.collins.kweku@ug.edu.gh		200	Computer Engineering	5000.00
22397491	Douglas Kwaw	Adjei	N/A	douglas.kwaw.adjei@ug.edu.gh		200	Computer Engineering	5000.00
22387715	Dzidzor Apu	Apawudza	N/A	dzidzor.apu.apawudza@ug.edu.gh		200	Computer Engineering	5000.00
22382302	Edward Kakra	Ankrah	N/A	edward.kakra.ankrah@ug.edu.gh		200	Computer Engineering	5000.00
22379061	Emmanuel Akotuah	Osae	N/A	emmanuel.akotuah.osae@ug.edu.gh		200	Computer Engineering	5000.00
22368809	Emmanuel	Dery	N/A	emmanuel.dery@ug.edu.gh		200	Computer Engineering	5000.00
22370498	Ethan Edric Kweku	Nartey	N/A	ethan.edric.kweku.nartey@ug.edu.gh		200	Computer Engineering	5000.00
22382425	Gilbert Akwasi Sarkodie	Yeboah	N/A	gilbert.akwasi.sarkodie.yeboah@ug.edu.gh		200	Computer Engineering	5000.00
22396551	Jerrold Xornam	Kyekye	N/A	jerrold.xornam.kyekye@ug.edu.gh		200	Computer Engineering	5000.00
22398562	Joseph	Amankwah	N/A	joseph.amankwah@ug.edu.gh		200	Computer Engineering	5000.00
22398596	Joshua	Appiah	N/A	joshua.appiah@ug.edu.gh		200	Computer Engineering	5000.00
22385323	Jude Gyampoh	Addo	N/A	jude.gyampoh.addo@ug.edu.gh		200	Computer Engineering	5000.00
22303421	Kemausuor Winambe	Tetteh-Kumah	N/A	kemausuor.winambe.tetteh-kumah@ug.edu.gh		200	Computer Engineering	5000.00
22407033	Kenzi	Segbefia	N/A	kenzi.segbefia@ug.edu.gh		200	Computer Engineering	5000.00
22299189	Kessey Ntiako	David	N/A	kessey.ntiako.david@ug.edu.gh		200	Computer Engineering	5000.00
22407837	Kingsley Caldicock	Quartey	N/A	kingsley.caldicock.quartey@ug.edu.gh		200	Computer Engineering	5000.00
22412615	Kofi Boateng	Oware-Tano	N/A	kofi.boateng.oware-tano@ug.edu.gh		200	Computer Engineering	5000.00
22411009	Kwaku Aninkorah	Barimah	N/A	kwaku.aninkorah.barimah@ug.edu.gh		200	Computer Engineering	5000.00
22382547	Kwame Ayeh	Obeng	N/A	kwame.ayeh.obeng@ug.edu.gh		200	Computer Engineering	5000.00
22373317	Kwamena Kesse	Quaicoe	N/A	kwamena.kesse.quaicoe@ug.edu.gh		200	Computer Engineering	5000.00
22339058	Maame Abena Amihere	Ahu	N/A	maame.abena.amihere.ahu@ug.edu.gh		200	Computer Engineering	5000.00
22302628	Maame Araba	Grant-Aidoo	N/A	maame.araba.grant-aidoo@ug.edu.gh		200	Computer Engineering	5000.00
22396566	Manford Kelvin	Oppong	N/A	manford.kelvin.oppong@ug.edu.gh		200	Computer Engineering	5000.00
22325819	Nana Adwoa Dansowaah	Odoom	N/A	nana.adwoa.dansowaah.odoom@ug.edu.gh		200	Computer Engineering	5000.00
22344703	Nana	Anokye	N/A	nana.anokye@ug.edu.gh		200	Computer Engineering	5000.00
22306910	Newlove Yeboaah	Kwarfo	N/A	newlove.yeboaah.kwarfo@ug.edu.gh		200	Computer Engineering	5000.00
22385472	Obeng Ernest	Antwi	N/A	obeng.ernest.antwi@ug.edu.gh		200	Computer Engineering	5000.00
22399214	Obeng	Ruth	N/A	obeng.ruth@ug.edu.gh		200	Computer Engineering	5000.00
22263126	Owusu Koranteng Yaw	Poku	N/A	owusu.koranteng.yaw.poku@ug.edu.gh		200	Computer Engineering	5000.00
22373463	Owusu Nana	Boadiwaa	N/A	owusu.nana.boadiwaa@ug.edu.gh		200	Computer Engineering	5000.00
22381702	Paula Akosua Asiedua	Frimpong	N/A	paula.akosua.asiedua.frimpong@ug.edu.gh		200	Computer Engineering	5000.00
22387846	Quaicoo	Emile	N/A	quaicoo.emile@ug.edu.gh		200	Computer Engineering	5000.00
22263922	Romel Alvin Nii Lartey	Lartey	N/A	romel.alvin.nii.lartey.lartey@ug.edu.gh		200	Computer Engineering	5000.00
22401641	Sandra Naa Adaku	Mettle	N/A	sandra.naa.adaku.mettle@ug.edu.gh		200	Computer Engineering	5000.00
22403781	Sekyere Kofi	Bempong	N/A	sekyere.kofi.bempong@ug.edu.gh		200	Computer Engineering	5000.00
22304260	Tetteh Christian Edward Nii	Mantey	N/A	tetteh.christian.edward.nii.mantey@ug.edu.gh		200	Computer Engineering	5000.00
22304013	Tietaah	Sonnu	N/A	tietaah.sonnu@ug.edu.gh		200	Computer Engineering	5000.00
22302188	Van Jerry	Quansah	N/A	van.jerry.quansah@ug.edu.gh		200	Computer Engineering	5000.00
22299949	William	Enchill	N/A	william.enchill@ug.edu.gh		200	Computer Engineering	5000.00
22415339	Kelvin Kwesi	Saah	N/A	kelvin.kwesi.saah@ug.edu.gh		200	Computer Engineering	5000.00
22328334	Etsey Hannah	Seyram	N/A	etsey.hannah.seyram@ug.edu.gh		200	Computer Engineering	5000.00
22412982	Adu	Mini	N/A	adu.mini@ug.edu.gh		200	Computer Engineering	5000.00
22321110	Gideon Nana Osei	Amofa	N/A	gideon.nana.osei.amofa@ug.edu.gh		200	Computer Engineering	5000.00
22306021	Paul Badu	Amponsah	N/A	paul.badu.amponsah@ug.edu.gh		200	Computer Engineering	5000.00
22385391	Najiib Abdul-Majeed	Stephen	N/A	najiib.abdul-majeed.stephen@ug.edu.gh		200	Computer Engineering	5000.00
22394866	Joshua Kwame	Asirifi	N/A	joshua.kwame.asirifi@ug.edu.gh		200	Computer Engineering	5000.00
22382601	Eklou	Juliet	N/A	eklou.juliet@ug.edu.gh		200	Computer Engineering	5000.00
22271867	De-Andra Rebecca	Ayebo	N/A	de-andra.rebecca.ayebo@ug.edu.gh		200	Computer Engineering	5000.00
224018189	Mas'ud	Nasir	N/A	mas'ud.nasir@ug.edu.gh		200	Computer Engineering	5000.00
22407018	Daniel Dwomoh	Frimpong	N/A	daniel.dwomoh.frimpong@ug.edu.gh		200	Computer Engineering	5000.00
22376708	Adjei	Priscilla	N/A	adjei.priscilla@ug.edu.gh		200	Computer Engineering	5000.00
22377537	Reuben	Adomako	N/A	reuben.adomako@ug.edu.gh		200	Computer Engineering	5000.00
22400543	Ocansey	Frederick	N/A	ocansey.frederick@ug.edu.gh		200	Computer Engineering	5000.00
22402666	Dogbatse	Darlington	N/A	dogbatse.darlington@ug.edu.gh		200	Computer Engineering	5000.00
22416112	Troy	Thomas	N/A	troy.thomas@ug.edu.gh		200	Computer Engineering	5000.00
22395074	Lydia	Tiwaah	N/A	lydia.tiwaah@ug.edu.gh		200	Computer Engineering	5000.00
\.


--
-- TOC entry 5083 (class 0 OID 24724)
-- Dependencies: 226
-- Data for Name: teaching_assistant; Type: TABLE DATA; Schema: university; Owner: postgres
--

COPY university.teaching_assistant (ta_id, first_name, last_name, email) FROM stdin;
1	Alice	Mensah	alice@ug.edu.gh
2	David	Owusu	david@ug.edu.gh
3	Michael	Asante	michael@ug.edu.gh
4	Ruth	Ofori	ruth@ug.edu.gh
5	Grace	Antwi	grace@ug.edu.gh
\.


--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 221
-- Name: course_course_id_seq; Type: SEQUENCE SET; Schema: university; Owner: postgres
--

SELECT pg_catalog.setval('university.course_course_id_seq', 5, true);


--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 227
-- Name: enrollment_enrollment_id_seq; Type: SEQUENCE SET; Schema: university; Owner: postgres
--

SELECT pg_catalog.setval('university.enrollment_enrollment_id_seq', 350, true);


--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 229
-- Name: fee_payment_payment_id_seq; Type: SEQUENCE SET; Schema: university; Owner: postgres
--

SELECT pg_catalog.setval('university.fee_payment_payment_id_seq', 70, true);


--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 231
-- Name: lecturer_course_assignment_id_seq; Type: SEQUENCE SET; Schema: university; Owner: postgres
--

SELECT pg_catalog.setval('university.lecturer_course_assignment_id_seq', 5, true);


--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 223
-- Name: lecturer_lecturer_id_seq; Type: SEQUENCE SET; Schema: university; Owner: postgres
--

SELECT pg_catalog.setval('university.lecturer_lecturer_id_seq', 5, true);


--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 233
-- Name: lecturer_ta_assignment_id_seq; Type: SEQUENCE SET; Schema: university; Owner: postgres
--

SELECT pg_catalog.setval('university.lecturer_ta_assignment_id_seq', 5, true);


--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 225
-- Name: teaching_assistant_ta_id_seq; Type: SEQUENCE SET; Schema: university; Owner: postgres
--

SELECT pg_catalog.setval('university.teaching_assistant_ta_id_seq', 5, true);


--
-- TOC entry 4904 (class 2606 OID 24712)
-- Name: course course_course_code_key; Type: CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.course
    ADD CONSTRAINT course_course_code_key UNIQUE (course_code);


--
-- TOC entry 4906 (class 2606 OID 24710)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (course_id);


--
-- TOC entry 4916 (class 2606 OID 24740)
-- Name: enrollment enrollment_pkey; Type: CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.enrollment
    ADD CONSTRAINT enrollment_pkey PRIMARY KEY (enrollment_id);


--
-- TOC entry 4918 (class 2606 OID 24759)
-- Name: fee_payment fee_payment_pkey; Type: CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.fee_payment
    ADD CONSTRAINT fee_payment_pkey PRIMARY KEY (payment_id);


--
-- TOC entry 4920 (class 2606 OID 24772)
-- Name: lecturer_course lecturer_course_pkey; Type: CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.lecturer_course
    ADD CONSTRAINT lecturer_course_pkey PRIMARY KEY (assignment_id);


--
-- TOC entry 4908 (class 2606 OID 24722)
-- Name: lecturer lecturer_email_key; Type: CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.lecturer
    ADD CONSTRAINT lecturer_email_key UNIQUE (email);


--
-- TOC entry 4910 (class 2606 OID 24720)
-- Name: lecturer lecturer_pkey; Type: CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.lecturer
    ADD CONSTRAINT lecturer_pkey PRIMARY KEY (lecturer_id);


--
-- TOC entry 4922 (class 2606 OID 24790)
-- Name: lecturer_ta lecturer_ta_pkey; Type: CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.lecturer_ta
    ADD CONSTRAINT lecturer_ta_pkey PRIMARY KEY (assignment_id);


--
-- TOC entry 4900 (class 2606 OID 24698)
-- Name: student student_email_key; Type: CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.student
    ADD CONSTRAINT student_email_key UNIQUE (email);


--
-- TOC entry 4902 (class 2606 OID 24696)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);


--
-- TOC entry 4912 (class 2606 OID 24732)
-- Name: teaching_assistant teaching_assistant_email_key; Type: CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.teaching_assistant
    ADD CONSTRAINT teaching_assistant_email_key UNIQUE (email);


--
-- TOC entry 4914 (class 2606 OID 24730)
-- Name: teaching_assistant teaching_assistant_pkey; Type: CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.teaching_assistant
    ADD CONSTRAINT teaching_assistant_pkey PRIMARY KEY (ta_id);


--
-- TOC entry 4926 (class 2606 OID 24778)
-- Name: lecturer_course fk_assignment_course; Type: FK CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.lecturer_course
    ADD CONSTRAINT fk_assignment_course FOREIGN KEY (course_id) REFERENCES university.course(course_id) ON DELETE CASCADE;


--
-- TOC entry 4927 (class 2606 OID 24773)
-- Name: lecturer_course fk_assignment_lecturer; Type: FK CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.lecturer_course
    ADD CONSTRAINT fk_assignment_lecturer FOREIGN KEY (lecturer_id) REFERENCES university.lecturer(lecturer_id) ON DELETE CASCADE;


--
-- TOC entry 4923 (class 2606 OID 24746)
-- Name: enrollment fk_course; Type: FK CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.enrollment
    ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES university.course(course_id) ON DELETE CASCADE;


--
-- TOC entry 4928 (class 2606 OID 24791)
-- Name: lecturer_ta fk_lt_lecturer; Type: FK CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.lecturer_ta
    ADD CONSTRAINT fk_lt_lecturer FOREIGN KEY (lecturer_id) REFERENCES university.lecturer(lecturer_id) ON DELETE CASCADE;


--
-- TOC entry 4929 (class 2606 OID 24796)
-- Name: lecturer_ta fk_lt_ta; Type: FK CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.lecturer_ta
    ADD CONSTRAINT fk_lt_ta FOREIGN KEY (ta_id) REFERENCES university.teaching_assistant(ta_id) ON DELETE CASCADE;


--
-- TOC entry 4925 (class 2606 OID 24760)
-- Name: fee_payment fk_payment_student; Type: FK CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.fee_payment
    ADD CONSTRAINT fk_payment_student FOREIGN KEY (student_id) REFERENCES university.student(student_id) ON DELETE CASCADE;


--
-- TOC entry 4924 (class 2606 OID 24741)
-- Name: enrollment fk_student; Type: FK CONSTRAINT; Schema: university; Owner: postgres
--

ALTER TABLE ONLY university.enrollment
    ADD CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES university.student(student_id) ON DELETE CASCADE;


-- Completed on 2026-07-25 02:18:09

--
-- PostgreSQL database dump complete
--

\unrestrict UyFTvZbjbryz9jPGlBSDFzgigrJNrgQeLkFBikEsttNoawzlRHEYjwJjwfncESH

