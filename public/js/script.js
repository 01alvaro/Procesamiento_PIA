// --- HACK DE ALTA RESOLUCIÓN (S25 Ultra Fix) ---
// Interceptamos la petición de cámara para forzar Full HD
if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
    const originalGUM = navigator.mediaDevices.getUserMedia.bind(navigator.mediaDevices);
    navigator.mediaDevices.getUserMedia = function(constraints) {
        if (constraints && constraints.video) {
            if (typeof constraints.video === 'boolean') {
                constraints.video = { width: { ideal: 1920 }, height: { ideal: 1080 } };
            } else {
                constraints.video.width = { ideal: 1920 };
                constraints.video.height = { ideal: 1080 };
            }
            console.log("🔧 Hack Resolución: Forzando 1080p...");
        }
        return originalGUM(constraints);
    };
}

// --- DATOS DE PAÍSES ---
const countries = [
    { id: 'colombia', name: 'Colombia', color: 'yellow' },
    { id: 'coreadelsur', name: 'Corea del Sur', color: 'white' },
    { id: 'espana', name: 'España', color: 'red' },
    { id: 'japon', name: 'Japón', color: 'white' },
    { id: 'mexico', name: 'México', color: 'green' },
    { id: 'paisesbajos', name: 'Países Bajos', color: 'orange' },
    { id: 'sudafrica', name: 'Sudáfrica', color: 'yellow' },
    { id: 'tunez', name: 'Túnez', color: 'red' },
    { id: 'uruguay', name: 'Uruguay', color: 'blue' },
    { id: 'uzbekistan', name: 'Uzbekistán', color: 'blue' }
];

document.addEventListener("DOMContentLoaded", () => {
    // Asignar los eventos a los targets que ahora están creados en el HTML
    countries.forEach((country) => {
        const entity = document.getElementById(`target-${country.id}`);
        if (entity) {
            entity.addEventListener('targetFound', () => {
                // Mostrar la información del país sin cambiar de página
                if (typeof window.mostrarInformacion === 'function') {
                    window.mostrarInformacion(country.id);
                }
            });
        }
    });
});
