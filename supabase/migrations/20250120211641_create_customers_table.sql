-- Create customers table
create table public.customers (
    id uuid primary key references auth.users(id),
    first_name text not null,
    last_name text not null,
    communication_channels text[] default '{}',
    preferred_language text,
    email text not null,
    feedback_history jsonb default '{"feedback": []}'::jsonb,
    created_at timestamptz default now() not null,
    updated_at timestamptz default now() not null
);

-- Add updated_at trigger
create trigger handle_updated_at before update on customers
    for each row execute procedure public.handle_updated_at();

-- Enable realtime
alter publication supabase_realtime add table customers;
