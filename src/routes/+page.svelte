<script lang="ts">
	import { onMount } from 'svelte';
	import { supabase } from '$lib/core/supabase/supabase-client';

	onMount(async () => {
		const { data } = await supabase.from('settings').select();
		console.log('data: ', data);
	});
</script>

<h1 class="text-3xl font-bold underline">Hello world!</h1>
