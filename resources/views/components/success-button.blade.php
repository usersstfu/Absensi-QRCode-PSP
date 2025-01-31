<button {{ $attributes->merge(['class' => 'bg-green-500 text-white font-bold py-2 px-4 rounded hover:bg-green-600 focus:outline-none focus:ring-2 focus:ring-green-400 focus:ring-opacity-75']) }}>
    {{ $slot }}
</button>
