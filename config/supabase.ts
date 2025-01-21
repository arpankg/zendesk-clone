import { createClient } from '@supabase/supabase-js'
import type { Database } from './types'

const isProduction = import.meta.env.PROD

const supabaseUrl = isProduction 
  ? import.meta.env.VITE_SUPABASE_PROD_URL 
  : import.meta.env.VITE_SUPABASE_LOCAL_URL

const supabaseAnonKey = isProduction
  ? import.meta.env.VITE_SUPABASE_PROD_ANON_KEY
  : import.meta.env.VITE_SUPABASE_LOCAL_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Missing Supabase environment variables')
}

export const supabase = createClient<Database>(supabaseUrl, supabaseAnonKey, {
  auth: {
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: true
  }
})
