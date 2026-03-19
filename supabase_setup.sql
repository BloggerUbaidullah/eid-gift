-- 1. Create the 'greetings' table
CREATE TABLE IF NOT EXISTS public.greetings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    image_url TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- 2. Enable Row Level Security (RLS)
ALTER TABLE public.greetings ENABLE ROW LEVEL SECURITY;

-- 3. Create a policy to allow anyone to read greetings
CREATE POLICY "Allow public read access" ON public.greetings
    FOR SELECT USING (true);

-- 4. Create a policy to allow anyone to insert greetings
CREATE POLICY "Allow public insert access" ON public.greetings
    FOR INSERT WITH CHECK (true);

-- 5. Storage Setup (Run these manually in the Supabase Storage UI if preferred)
-- Create a public bucket named 'eid-images'
-- In the Supabase Dashboard:
-- 1. Go to Storage -> New Bucket
-- 2. Name: eid-images
-- 3. Public: Yes (Toggle on)
-- 4. Click Create

-- 6. Storage Policies (Run these in the SQL Editor)
-- Allow public access to read files in 'eid-images'
CREATE POLICY "Public Access" ON storage.objects FOR SELECT USING (bucket_id = 'eid-images');

-- Allow public access to upload files to 'eid-images'
CREATE POLICY "Public Upload" ON storage.objects FOR INSERT WITH CHECK (bucket_id = 'eid-images');
