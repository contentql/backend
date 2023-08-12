SET check_function_bodies = false;
CREATE TABLE public.todos (
    id uuid NOT NULL,
    task text NOT NULL,
    completed boolean DEFAULT false NOT NULL
);
ALTER TABLE ONLY public.todos
    ADD CONSTRAINT todos_pkey PRIMARY KEY (id);
