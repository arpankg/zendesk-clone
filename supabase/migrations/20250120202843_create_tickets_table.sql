-- Set timezone
alter database postgres set timezone to 'America/New_York';

-- Create handle_updated_at function
create or replace function public.handle_updated_at()
returns trigger as $$
begin
    new.updated_at = now();
    return new;
end;
$$ language plpgsql;

-- Create tickets table
create table public.tickets (
    id uuid primary key default uuid_generate_v4(),
    title text not null,
    status text not null check (status in ('new', 'open', 'pending', 'closed')),
    priority text not null check (priority in ('low', 'medium', 'high')),
    tags text[] default '{}',
    custom_fields jsonb default '{}',
    conversation_history jsonb default '{}',
    internal_notes jsonb default '{}',
    feedback jsonb default '{}',
    source_channel text,
    created_at timestamptz default now() not null,
    updated_at timestamptz default now() not null,
    created_by uuid references auth.users(id),
    assigned_to uuid references auth.users(id)
);

-- Add updated_at trigger
create trigger handle_updated_at before update on tickets
    for each row execute procedure public.handle_updated_at();

-- Enable realtime
alter publication supabase_realtime add table tickets;