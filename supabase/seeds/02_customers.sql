-- Customer 3: International user
INSERT INTO auth.users (
    id,
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '7d3e41c9-9a5d-4e4f-a71c-94b17e8f6e24',
    'carlos.garcia@example.com',
    now() - interval '60 days',
    now() - interval '5 days',
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.customers (
    id,
    first_name,
    last_name,
    communication_channels,
    preferred_language,
    email,
    feedback_history,
    created_at,
    updated_at
) VALUES (
    '7d3e41c9-9a5d-4e4f-a71c-94b17e8f6e24',
    'Carlos',
    'Garcia',
    ARRAY['web', 'email'],
    'es',
    'carlos.garcia@example.com',
    '{
        "feedback": [
            {
                "rating": 3,
                "comment": "Servicio regular, problemas de idioma",
                "submitted_at": "2024-11-28T16:45:00Z",
                "ticket_id": "14d0f1ee-6c54-4b01-90e6-d701748f0853"
            }
        ]
    }'::jsonb,
    now() - interval '60 days',
    now() - interval '60 days'
);

-- Customer 4: New user
INSERT INTO auth.users (
    id,
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'a1b2c3d4-e5f6-4a5b-9c8d-1a2b3c4d5e6f',
    'john.doe@example.com',
    now() - interval '2 days',
    now() - interval '1 day',
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.customers (
    id,
    first_name,
    last_name,
    communication_channels,
    preferred_language,
    email,
    feedback_history,
    created_at,
    updated_at
) VALUES (
    'a1b2c3d4-e5f6-4a5b-9c8d-1a2b3c4d5e6f',
    'John',
    'Doe',
    ARRAY['web'],
    'en',
    'john.doe@example.com',
    '{"feedback": []}'::jsonb,
    now() - interval '2 days',
    now() - interval '2 days'
);

-- Customer 5: Power user with multiple channels
INSERT INTO auth.users (
    id,
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'b5e7d31c-8a2f-4b9c-9d6e-f4c3a2b1e0d9',
    'emma.wilson@example.com',
    now() - interval '90 days',
    now(),
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.customers (
    id,
    first_name,
    last_name,
    communication_channels,
    preferred_language,
    email,
    feedback_history,
    created_at,
    updated_at
) VALUES (
    'b5e7d31c-8a2f-4b9c-9d6e-f4c3a2b1e0d9',
    'Emma',
    'Wilson',
    ARRAY['web', 'email', 'chat', 'phone'],
    'en',
    'emma.wilson@example.com',
    '{
        "feedback": [
            {
                "rating": 5,
                "comment": "Excellent support every time!",
                "submitted_at": "2024-12-28T11:20:00Z",
                "ticket_id": "24d0f1ee-6c54-4b01-90e6-d701748f0854"
            },
            {
                "rating": 5,
                "comment": "Very helpful team",
                "submitted_at": "2024-12-10T13:45:00Z",
                "ticket_id": "34d0f1ee-6c54-4b01-90e6-d701748f0855"
            },
            {
                "rating": 4,
                "comment": "Good service overall",
                "submitted_at": "2024-11-15T09:30:00Z",
                "ticket_id": "44d0f1ee-6c54-4b01-90e6-d701748f0856"
            }
        ]
    }'::jsonb,
    now() - interval '90 days',
    now() - interval '90 days'
);
