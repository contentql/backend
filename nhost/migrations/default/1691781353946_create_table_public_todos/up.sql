CREATE TABLE public.todos (id uuid NOT NULL, task text NOT NULL, completed bool DEFAULT 'false' NOT NULL, PRIMARY KEY (id));
