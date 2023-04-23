create table "public"."user_settings" (
    "user_id" uuid not null,
    "created_at" timestamp with time zone default now(),
    "tasks" jsonb default '[]'::jsonb,
    "is_enabled" boolean not null default false
);


alter table "public"."user_settings" enable row level security;

CREATE UNIQUE INDEX user_settings_pkey ON public.user_settings USING btree (user_id);

alter table "public"."user_settings" add constraint "user_settings_pkey" PRIMARY KEY using index "user_settings_pkey";

alter table "public"."user_settings" add constraint "user_settings_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."user_settings" validate constraint "user_settings_user_id_fkey";
