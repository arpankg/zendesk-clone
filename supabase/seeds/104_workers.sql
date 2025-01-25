-- Worker 7: Alicia DiMatteo
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '9bd22891-10d2-4efe-904f-fd5604cb91cf',
    'alicia.dimatteo@company.com',
    now() - interval '4 days',
    now() - interval '1 days',
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
    '9bd22891-10d2-4efe-904f-fd5604cb91cf',
    'alicia.dimatteo@company.com',
    'Alicia',
    'DiMatteo',
    'Training Specialist',
    'America/Los_Angeles',
    ARRAY['User Training', 'Onboarding'],
    ARRAY['en', 'es'],
    '{"tickets_resolved": 1, "avg_response_time": 50}'::jsonb,
    '{}',
    '[]'::jsonb,
    now() - interval '4 days'
);

-- Worker 8: Danielle Rios
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '691267c4-4ad1-4ea8-a9b1-bef8f8b45dc1',
    'danielle.rios@company.com',
    now() - interval '9 days',
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
    '691267c4-4ad1-4ea8-a9b1-bef8f8b45dc1',
    'danielle.rios@company.com',
    'Danielle',
    'Rios',
    'Quality Assurance',
    'America/Sao_Paulo',
    ARRAY['QA Testing', 'Bug Reporting'],
    ARRAY['en', 'pt'],
    '{"tickets_resolved": 4, "avg_response_time": 40}'::jsonb,
    '{}',
    '[]'::jsonb,
    now() - interval '9 days'
);
