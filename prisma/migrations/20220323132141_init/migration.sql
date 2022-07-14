CREATE TYPE public.source_enum AS ENUM ('testA', 'testB');

CREATE TABLE public.testing_enums (
	id UUID NOT NULL DEFAULT gen_random_uuid(),
	title STRING NOT NULL,
	kind STRING NOT NULL,
	source public.source_enum NOT NULL DEFAULT 'testA':::public.source_enum,
	CONSTRAINT "PK_id" PRIMARY KEY (id ASC),
	CONSTRAINT "CHK_kind" CHECK ((kind = 'affirmation':::STRING) OR (kind = 'reversal':::STRING))
);

CREATE TABLE public.parent_tests (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    title STRING NOT NULL,
    enum_id UUID NOT NULL,
    CONSTRAINT "FK_testing_enums" FOREIGN KEY (enum_id) REFERENCES public.testing_enums(id)
);

INSERT INTO testing_enums VALUES ('fd4e86f2-0307-11ed-b939-0242ac120002', 'test title', 'affirmation', 'testA');
INSERT INTO parent_tests VALUES (default, 'test title', 'fd4e86f2-0307-11ed-b939-0242ac120002');
