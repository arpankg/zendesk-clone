-- Insert into auth.users
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin,
    provider
)
VALUES (
    '5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58',
    'test@gmail.com',
    now(),
    now(),
    '{"provider":"email","providers":["email"]}',
    '{}',
    false,
    'email'
);

-- Insert into customers
INSERT INTO public.customers (
    id,
    first_name,
    last_name,
    communication_channels,
    preferred_language,
    email,
    feedback_history
)
VALUES (
    '5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58',
    'Test',
    'User',
    ARRAY['web'],
    'en',
    'test@gmail.com',
    '{"feedback": []}'::jsonb
);