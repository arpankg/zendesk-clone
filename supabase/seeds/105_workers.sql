-- Worker 9: Aaron Gallant
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'd7c9c948-17c0-45e3-91c4-83dcf2eb3c5b',
    'aaron.gallant@company.com',
    now() - interval '6 days',
    now() - interval '2 days',
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.workers (
    id,
    email,
    first_name,
    last_name,
    role,
    timezone,
    skills,
    languages,
    metrics,
    assigned_tickets,
    ticket_history,
    created_at
) VALUES (
    'd7c9c948-17c0-45e3-91c4-83dcf2eb3c5b',
    'aaron.gallant@company.com',
    'Aaron',
    'Gallant',
    'Operations Manager',
    'America/New_York',
    ARRAY['Process Improvement', 'Team Management'],
    ARRAY['en', 'fr'],
    '{"tickets_resolved": 7, "avg_response_time": 23}'::jsonb,
    '{}',
    '[]'::jsonb,
    now() - interval '6 days'
);

-- Worker 10: Elias Torres
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '844efffc-1a03-4e87-bf6c-aa7afbe776ba',
    'elias.torres@company.com',
    now() - interval '14 days',
    now() - interval '5 days',
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.workers (
    id,
    email,
    first_name,
    last_name,
    role,
    timezone,
    skills,
    languages,
    metrics,
    assigned_tickets,
    ticket_history,
    created_at
) VALUES (
    '844efffc-1a03-4e87-bf6c-aa7afbe776ba',
    'elias.torres@company.com',
    'Elias',
    'Torres',
    'Analytics Engineer',
    'America/Chicago',
    ARRAY['Data Analysis', 'Reporting'],
    ARRAY['en', 'es'],
    '{"tickets_resolved": 0, "avg_response_time": 0}'::jsonb,
    '{}',
    '[]'::jsonb,
    now() - interval '14 days'
);
