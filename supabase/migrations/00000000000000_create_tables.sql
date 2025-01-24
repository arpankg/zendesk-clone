-- Set timezone
alter database postgres set timezone to 'America/New_York';

------------------------------------------
-- Setup Functions
------------------------------------------

-- Create handle_updated_at function for automatic timestamp updates
create or replace function public.handle_updated_at()
returns trigger as $$
begin
    new.updated_at = now();
    return new;
end;
$$ language plpgsql;

------------------------------------------
-- Create Customers Table
------------------------------------------

create table public.customers (
    -- Primary key linking to auth.users
    id uuid primary key references auth.users(id),
    
    -- Required fields
    first_name text not null,
    last_name text not null,
    email text not null,
    
    -- Optional fields with defaults
    communication_channels text[] default '{}',
    preferred_language text,
    feedback_history jsonb default '{"feedback": []}'::jsonb,
    
    -- Timestamps
    created_at timestamptz default now() not null,
    updated_at timestamptz default now() not null
);

-- Add unique constraint to email (required for foreign key reference)
alter table public.customers add constraint customers_email_unique unique (email);

-- Add updated_at trigger for customers
create trigger handle_updated_at before update on customers
    for each row execute procedure public.handle_updated_at();

------------------------------------------
-- Create Workers Table
------------------------------------------

create table public.workers (
    -- Primary key linking to auth.users
    id uuid primary key references auth.users(id),
    
    -- Required fields
    email text not null unique,
    first_name text not null,
    last_name text not null,
    role text not null,
    timezone text not null,
    
    -- Optional fields with defaults
    skills text[] default '{}',
    languages text[] default '{}',
    metrics jsonb default '{}',
    assigned_tickets uuid[] default '{}',
    ticket_history jsonb default '[]'::jsonb,
    
    -- Timestamps
    created_at timestamptz default now() not null
);

------------------------------------------
-- Create Tickets Table
------------------------------------------

create table public.tickets (
    -- Primary key
    id uuid primary key default uuid_generate_v4(),
    
    -- Required fields
    title text not null,
    description text not null,
    status text not null check (status in ('new', 'open', 'pending', 'closed')),
    priority text not null check (priority in ('low', 'medium', 'high')),
    
    -- Optional fields with defaults
    tags text[] default '{}',
    custom_fields jsonb default '{}',
    ticket_history jsonb default '{"events": []}'::jsonb,
    internal_notes jsonb default '{"notes": []}'::jsonb,
    feedback jsonb default '{}',
    source_channel text,
    
    -- Timestamps
    created_at timestamptz default now() not null,
    updated_at timestamptz default now() not null,
    
    -- Foreign keys and references
    created_by uuid references auth.users(id),
    customer_email text references public.customers(email),
    assigned_to jsonb default '[]'::jsonb
);

-- Add updated_at trigger for tickets
create trigger handle_updated_at before update on tickets
    for each row execute procedure public.handle_updated_at();

------------------------------------------
-- Enable Realtime
------------------------------------------

-- Enable realtime for both tables
alter publication supabase_realtime add table customers;
alter publication supabase_realtime add table tickets;