-- Sample customer data for the support system
-- Each customer has different communication preferences and history

-- Existing customers (DO NOT REMOVE):

-- Customer 1: Basic web user
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58',
    'test@gmail.com',
    now(),
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
    '5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58',
    'Test',
    'User',
    ARRAY['web'],
    'en',
    'test@gmail.com',
    '{"feedback": []}'::jsonb,
    now(),
    now()
);

-- Customer 2: Multi-channel user with feedback history
INSERT INTO auth.users (
    id,
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'f23c5c88-2322-4c2d-9f59-43e79a9b5c44',
    'sarah.miller@example.com',
    now() - interval '30 days',
    now() - interval '2 days',
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
    'f23c5c88-2322-4c2d-9f59-43e79a9b5c44',
    'Sarah',
    'Miller',
    ARRAY['web', 'email', 'chat'],
    'en',
    'sarah.miller@example.com',
    '{
        "feedback": [
            {
                "rating": 5,
                "comment": "Great support team!",
                "submitted_at": "2024-12-20T14:30:00Z",
                "ticket_id": "d290f1ee-6c54-4b01-90e6-d701748f0851"
            },
            {
                "rating": 4,
                "comment": "Quick response, but needed follow-up",
                "submitted_at": "2024-12-15T09:15:00Z",
                "ticket_id": "04d0f1ee-6c54-4b01-90e6-d701748f0852"
            }
        ]
    }'::jsonb,
    now() - interval '30 days',
    now() - interval '30 days'
);
