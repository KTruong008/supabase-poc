create type "auth"."code_challenge_method" as enum ('s256', 'plain');

create table "auth"."flow_state" (
    "id" uuid not null,
    "user_id" uuid,
    "auth_code" text not null,
    "code_challenge_method" auth.code_challenge_method not null,
    "code_challenge" text not null,
    "provider_type" text not null,
    "provider_access_token" text,
    "provider_refresh_token" text,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "authentication_method" text not null
);


CREATE UNIQUE INDEX flow_state_pkey ON auth.flow_state USING btree (id);

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);

alter table "auth"."flow_state" add constraint "flow_state_pkey" PRIMARY KEY using index "flow_state_pkey";


create table "public"."settings" (
    "user_id" uuid not null,
    "created_at" timestamp with time zone default now(),
    "tasks" jsonb default '[]'::jsonb,
    "is_enabled" boolean default false,
    "app_subscription_type" text
);


alter table "public"."settings" enable row level security;

CREATE UNIQUE INDEX settings_pkey ON public.settings USING btree (user_id);

alter table "public"."settings" add constraint "settings_pkey" PRIMARY KEY using index "settings_pkey";

alter table "public"."settings" add constraint "settings_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."settings" validate constraint "settings_user_id_fkey";


