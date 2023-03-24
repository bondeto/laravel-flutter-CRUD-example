<?php

namespace App\Http\Controllers;

use App\Models\Produk;
use Illuminate\Http\Request;

class ProdukApiController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $products = Produk::orderBy('created_at', 'desc')->get();
        return response()->json(
            [
                'message' => 'ok',
                'data' => $products,

            ]

        );
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'deskripsi' => 'required',
            'harga' => 'required',

        ]);

        Produk::create($request->all());
        return response()->json(
            [
                'message' => 'ok',
                'data' => 'Produk Added',

            ]

        );
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        //
        $products = Produk::find($id);
        return response()->json(
            [
                'message' => 'ok',
                'data' => $products,

            ]

        );
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Produk $produk)
    {
        $products = Produk::find($produk);
        return response()->json(
            [
                'message' => 'ok',
                'data' => $products,

            ]

        );
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        $products = Produk::find($id);
        #dd($request->name);
        $products->update($request->all());
        return response()->json(
            [
                'message' => 'ok',
                'data' => 'updated '. $request->name,

            ]

        );
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Produk $produk)
    {
        $produk->delete();
        return response()->json(
            [
                'message' => 'ok',
                'data' => 'Delete Sukses ',

            ]);
    }
}
