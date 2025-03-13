
import React from 'react';
import { Link } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { isAuthenticated } from '@/data';

const Hero = () => {
  return (
    <div className="relative">
      {/* Hero Background */}
      <div className="absolute inset-0 overflow-hidden z-0">
        <img 
          src="https://images.unsplash.com/photo-1583855282680-6dbdc69b0932" 
          alt="Recife Antigo"
          className="w-full h-full object-cover"
        />
        <div className="absolute inset-0 bg-gradient-to-b from-recife-primary/60 to-recife-primary/90"></div>
      </div>
      
      {/* Hero Content */}
      <div className="relative z-10 container mx-auto px-4 py-16 md:py-24 text-white">
        <div className="max-w-3xl">
          <h1 className="text-4xl md:text-6xl font-bold mb-6">
            Descubra a História de Recife
          </h1>
          
          <p className="text-xl md:text-2xl text-white/90 mb-8">
            Junte-se a nós na documentação e preservação da rica história de nossa cidade. Compartilhe suas histórias e participe da competição.
          </p>
          
          <div className="flex flex-wrap gap-4">
            <Link to="/locations">
              <Button size="lg" className="bg-white text-recife-primary hover:bg-gray-100">
                Explorar Locais
              </Button>
            </Link>
            
            {isAuthenticated() ? (
              <Link to="/dashboard">
                <Button size="lg" variant="outline" className="border-white text-white hover:bg-white/20">
                  Meu Dashboard
                </Button>
              </Link>
            ) : (
              <Button size="lg" variant="outline" className="border-white text-white hover:bg-white/20">
                Participar
              </Button>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Hero;
